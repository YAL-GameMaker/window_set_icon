/// @author YellowAfterlife

#define _HAS_STD_BYTE 0
#include "stdafx.h"
#include <CommCtrl.h>
#include <shlobj.h>
#include "tiny_string.h"

tiny_wstring utf8;

ITaskbarList3* taskbarList3 = nullptr;

typedef struct {
	BYTE        bWidth;          // Width, in pixels, of the image
	BYTE        bHeight;         // Height, in pixels, of the image
	BYTE        bColorCount;     // Number of colors in image (0 if >=8bpp)
	BYTE        bReserved;       // Reserved ( must be 0)
	WORD        wPlanes;         // Color Planes
	WORD        wBitCount;       // Bits per pixel
	DWORD       dwBytesInRes;    // How many bytes in this resource?
	DWORD       dwImageOffset;   // Where in the file is this image?
} ICONDIRENTRY, * LPICONDIRENTRY;

struct window_set_icon_data {
	int32_t size;
	HRESULT result;
	char info[120];
	inline bool set(HRESULT _result, const char* _info, bool _ret = false) {
		result = _result;
		strncpy(info, _info, sizeof(info));
		return _ret;
	}
	inline bool setLastError(const char* _info, bool _ret = false) {
		auto e = GetLastError();
		result = HRESULT_FROM_WIN32(e);
		strncpy(info, _info, sizeof(info));
		return _ret;
	}
};

struct {
	HICON bigIcon = NULL, smallIcon = NULL;
	bool isSet = false;
	void check(HWND hwnd) {
		if (!isSet) {
			isSet = true;
			bigIcon = (HICON)SendMessageW(hwnd, WM_GETICON, ICON_BIG, 0);
			smallIcon = (HICON)SendMessageW(hwnd, WM_GETICON, ICON_SMALL, 0);
		}
	}
} defIcon;

struct PreserveIcon {
	HICON icon = NULL;
	void init() {
		icon = NULL;
	}
	void set(HICON val) {
		if (icon) DestroyIcon(icon);
		icon = val;
	}
};
struct PreserveBitmap {
	HBITMAP bitmap = NULL;
	void init() {
		bitmap = NULL;
	}
	void set(HBITMAP val) {
		if (bitmap) DeleteObject(bitmap);
		bitmap = val;
	}
};

static struct {
	HICON icons[2]{};
	bool enable = false;
	WNDPROC base = nullptr;
	void init() {
		icons[0] = false;
		icons[1] = false;
		enable = false;
		base = nullptr;
	}
} window_icon_hook;

LRESULT window_command_proc_hook(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp) {
	if (msg == WM_SETICON && window_icon_hook.enable) {
		HICON icon;
		switch (wp) {
			case ICON_SMALL:
				icon = window_icon_hook.icons[0];
				break;
			case ICON_BIG:
				icon = window_icon_hook.icons[1];
				break;
			default: icon = NULL;
		}
		if (icon != NULL) lp = (LPARAM)icon;
	}
	return CallWindowProc(window_icon_hook.base, hwnd, msg, wp, lp);
}
void window_icon_hook_ensure(HWND hwnd) {
	if (window_icon_hook.base == nullptr) {
		window_icon_hook.base = (WNDPROC)SetWindowLongPtr(hwnd, GWLP_WNDPROC, (LONG_PTR)window_command_proc_hook);
	}
}

PBYTE PickBestMatchIcon(BYTE* icoData, size_t icoSize, int cx, int cy) {
	auto count = *(WORD*)(icoData + 2 * sizeof(WORD));
	if (count == 0) return NULL;
	auto entries = (ICONDIRENTRY*)(icoData + 3 * sizeof(WORD));

	// direct match?:
	for (int i = 0; i < count; i++) {
		auto& entry = entries[i];
		if (entry.bColorCount > 0) continue;
		if (entry.bWidth == cx && entry.bHeight == cy) return icoData + entry.dwImageOffset;
	}

	// smallest icon that is >=2x?:
	int bw = 0, bh = 0;
	PBYTE bb = NULL;
	for (int i = 0; i < count; i++) {
		auto& entry = entries[i];
		if (entry.bColorCount > 0) continue;
		auto w = entry.bWidth;
		auto h = entry.bHeight;
		if (w < cx * 2 || h < cy * 2) continue;
		if (bb == NULL || (w < bw && h < bh)) {
			bb = icoData + entry.dwImageOffset;
			bw = w;
			bh = h;
		}
	}
	if (bb) return bb;

	// just pick the biggest icon then:
	bw = 0; bh = 0;
	bb = NULL;
	for (int i = 0; i < count; i++) {
		auto& entry = entries[i];
		if (entry.bColorCount > 0) continue;
		auto w = entry.bWidth;
		auto h = entry.bHeight;
		if (w > bw && h > bh)
			if (w < cx * 2 || h < cy * 2) continue;
		if (bb == NULL || (w < bw && h < bh)) {
			bb = icoData + entry.dwImageOffset;
			bw = w;
			bh = h;
		}
	}
	return bb;
}

HICON LoadIconFromBuffer(BYTE* data, size_t size, int cx, int cy) {
	// https://stackoverflow.com/a/51806326/5578773
	auto icon_count = *(WORD*)(data + 2 * sizeof(WORD));
	auto resBits = PickBestMatchIcon(data, size, cx, cy);
	auto resSize = data + size - resBits;
	// "This parameter is generally set to 0x00030000."
	// https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-createiconfromresourceex
	constexpr auto ver = 0x00030000;
	return CreateIconFromResourceEx(resBits, (DWORD)resSize, TRUE, ver, cx, cy, LR_DEFAULTCOLOR);
}

PreserveIcon currSmall, currBig;
dllx double window_set_icon_raw(void* _hwnd, uint8_t* data, window_set_icon_data* out) {

	auto cx = GetSystemMetrics(SM_CXSMICON);
	auto cy = GetSystemMetrics(SM_CYSMICON);
	auto nextSmall = LoadIconFromBuffer(data, out->size, cx, cy);
	if (!nextSmall) {
		auto error = GetLastError();
		auto result = HRESULT_FROM_WIN32(error);
		out->set(result, "CreateIconFromResourceEx (small)");
		return false;
	}

	cx = GetSystemMetrics(SM_CXICON);
	cy = GetSystemMetrics(SM_CYICON);
	auto nextBig = LoadIconFromBuffer(data, out->size, cx, cy);
	if (!nextBig) {
		auto error = GetLastError();
		auto result = HRESULT_FROM_WIN32(error);
		out->set(result, "CreateIconFromResourceEx (big)");
		DestroyIcon(nextSmall);
		return false;
	}

	auto hwnd = (HWND)_hwnd;
	defIcon.check(hwnd);

	currSmall.set(nextSmall);
	currBig.set(nextBig);

	window_icon_hook.icons[0] = nextSmall;
	window_icon_hook.icons[1] = nextBig;
	window_icon_hook_ensure(hwnd);

	window_icon_hook.enable = false;
	SendMessage(hwnd, WM_SETICON, ICON_SMALL, (LPARAM)nextSmall);
	SendMessage(hwnd, WM_SETICON, ICON_BIG, (LPARAM)nextBig);
	window_icon_hook.enable = true;

	out->set(S_OK, "All good!");
	return true;
}

struct window_set_icon_surface_data {
	int32_t width;
	int32_t height;
	int32_t flags;
	HRESULT result;
	char info[112];
	inline bool set(HRESULT _result, const char* _info, bool _ret = false) {
		result = _result;
		strncpy(info, _info, sizeof(info));
		return _ret;
	}
	inline bool setLastError(const char* _info, bool _ret = false) {
		auto e = GetLastError();
		result = HRESULT_FROM_WIN32(e);
		strncpy(info, _info, sizeof(info));
		return _ret;
	}
};
inline HICON CreateIconFromBitmap(HBITMAP bmp) {
	ICONINFO inf{};
	inf.fIcon = true;
	inf.hbmMask = bmp;
	inf.hbmColor = bmp;
	return CreateIconIndirect(&inf);
}
static bool SwapRedBlue_needed = true;
void SwapRedBlue(uint8_t* buf, size_t count) {
	if (!SwapRedBlue_needed) return;
	size_t i = 0;
	const size_t count_nand_3 = count & ~3;
	while (i < count_nand_3) {
		std::swap(buf[i], buf[i + 2]);
		std::swap(buf[i + 4], buf[i + 6]);
		std::swap(buf[i + 8], buf[i + 10]);
		std::swap(buf[i + 12], buf[i + 14]);
		i += 16;
	}
	for (; i < count; i += 4) std::swap(buf[i], buf[i + 2]);
}

dllx double window_set_icon_surface_raw(void* _hwnd, uint8_t* rgba, window_set_icon_surface_data* out) {
	static PreserveIcon lastIcon[2];
	static PreserveBitmap lastBitmap[2];
	//
	SwapRedBlue(rgba, out->width * out->height * 4);
	auto bmp = CreateBitmap(out->width, out->height, 1, 32, rgba);
	if (bmp == NULL) return out->set(E_FAIL, "CreateBitmap");
	//
	auto icon = CreateIconFromBitmap(bmp);
	if (icon == NULL) {
		DeleteObject(bmp);
		return out->setLastError("CreateIconIndirect");
	}
	//
	int big = (out->flags & 1);
	lastIcon[big].set(icon);
	lastBitmap[big].set(bmp);
	window_icon_hook.icons[big] = icon;
	//
	auto hwnd = (HWND)_hwnd;
	defIcon.check(hwnd);
	WPARAM wp = big ? ICON_BIG : ICON_SMALL;

	window_icon_hook_ensure(hwnd);
	window_icon_hook.enable = false;
	SendMessage(hwnd, WM_SETICON, wp, (LPARAM)icon);
	window_icon_hook.enable = true;

	out->set(S_OK, "All good!");
	return true;
}

dllx double window_reset_icon_raw(void* _hwnd) {
	if (!defIcon.isSet) return true;
	auto hwnd = (HWND)_hwnd;
	window_icon_hook.icons[0] = NULL;
	window_icon_hook.icons[1] = NULL;

	window_icon_hook.enable = false;
	SendMessage(hwnd, WM_SETICON, ICON_SMALL, (LPARAM)defIcon.smallIcon);
	SendMessage(hwnd, WM_SETICON, ICON_BIG, (LPARAM)defIcon.bigIcon);
	window_icon_hook.enable = true;

	return true;
}

dllx double window_sync_icon_raw(void* _hwnd) {
	if (!defIcon.isSet) return true;
	auto hwnd = (HWND)_hwnd;
	HICON icon;

	window_icon_hook.enable = false;
	//
	icon = window_icon_hook.icons[0];
	if (icon == NULL) icon = defIcon.smallIcon;
	SendMessage(hwnd, WM_SETICON, ICON_SMALL, (LPARAM)icon);
	//
	icon = window_icon_hook.icons[1];
	if (icon == NULL) icon = defIcon.bigIcon;
	SendMessage(hwnd, WM_SETICON, ICON_BIG, (LPARAM)defIcon.bigIcon);
	//
	window_icon_hook.enable = true;

	return true;
}

dllx double window_set_overlay_icon_raw(void* hwnd, uint8_t* data, const char* desc, window_set_icon_data* out) {
	static PreserveIcon lastIcon;

	//
	if (!taskbarList3) {
		auto result = CoCreateInstance(CLSID_TaskbarList, NULL, CLSCTX_ALL, IID_ITaskbarList3, (void**)&taskbarList3);
		if (result != S_OK) {
			out->set(result, "CoCreateInstance(CLSID_TaskbarList)");
			return false;
		}
	}

	auto cx = GetSystemMetrics(SM_CXSMICON);
	auto cy = GetSystemMetrics(SM_CYSMICON);
	auto icon = LoadIconFromBuffer(data, out->size, cx, cy);
	if (!icon) {
		auto error = GetLastError();
		auto result = HRESULT_FROM_WIN32(error);
		out->set(result, "CreateIconFromResourceEx");
		return false;
	}

	//
	auto result = taskbarList3->SetOverlayIcon((HWND)hwnd, icon, utf8.conv(desc));
	if (result != S_OK) {
		DestroyIcon(icon);
		out->set(result, "ITaskbarList3::SetOverlayIcon");
		return false;
	}
	lastIcon.set(icon);
	out->set(S_OK, "All good!");
	return true;
}

dllx double window_set_overlay_icon_surface_raw(void* _hwnd, uint8_t* rgba, const char* desc, window_set_icon_surface_data* out) {
	static PreserveIcon lastIcon;
	static PreserveBitmap lastBitmap;

	//
	if (!taskbarList3) {
		auto result = CoCreateInstance(CLSID_TaskbarList, NULL, CLSCTX_ALL, IID_ITaskbarList3, (void**)&taskbarList3);
		if (result != S_OK) {
			out->set(result, "CoCreateInstance(CLSID_TaskbarList)");
			return false;
		}
	}

	//
	SwapRedBlue(rgba, out->width * out->height * 4);
	auto bmp = CreateBitmap(out->width, out->height, 1, 32, rgba);
	if (bmp == NULL) return out->set(E_FAIL, "CreateBitmap");

	//
	auto icon = CreateIconFromBitmap(bmp);
	if (icon == NULL) {
		DeleteObject(bmp);
		return out->setLastError("CreateIconIndirect");
	}

	//
	auto result = taskbarList3->SetOverlayIcon((HWND)_hwnd, icon, utf8.conv(desc));
	if (result != S_OK) {
		DeleteObject(bmp);
		DestroyIcon(icon);
		return out->set(result, "ITaskbarList3::SetOverlayIcon");
	}
	lastIcon.set(icon);
	lastBitmap.set(bmp);
	return out->set(S_OK, "All good!", true);
}

dllx double window_reset_overlay_icon_raw(void* hwnd) {
	if (!taskbarList3) return true;
	taskbarList3->SetOverlayIcon((HWND)hwnd, NULL, L"");
	return true;
}

dllg bool window_set_icon_init_raw(double isRGBA) {
	SwapRedBlue_needed = isRGBA > 0.5;
	return true;
}

void init() {
	utf8.init();
	currSmall.init();
	currBig.init();
	window_icon_hook.init();
}
BOOL APIENTRY DllMain(HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved) {
	if (ul_reason_for_call == DLL_PROCESS_ATTACH) init();
	return TRUE;
}
