#define window_set_icon_init
//#macro window_set_icon_hresult global.g_window_set_icon_hresult
//#macro window_set_icon_context global.g_window_set_icon_context
window_set_icon_hresult = 0;
window_set_icon_context = "";
global.g_window_set_icon_argbuf = -1;
global.g_window_set_icon_path = undefined;
global.g_window_set_icon_buffer = -1;
global.g_window_set_overlay_icon_path = undefined;
global.g_window_set_overlay_icon_buffer = -1;
global.s_window_set_icon_dll_missing = "DLL is not loaded";
global.s_window_set_icon_file_exists = "File does not exist";
global.s_window_set_icon_buffer_load = "Failed to load file";
global.s_window_set_icon_all_good = "All good!";
global.s_window_set_icon_reuse = "Already using this icon - no action needed";

#define window_set_icon
/// (path_to_an_ico)
var _path = argument0;
//
if (_path == global.g_window_set_icon_path) {
	window_set_icon_hresult = 0;
	window_set_icon_context = global.s_window_set_icon_reuse;
	return true;
}

if (!file_exists(_path)) {
	window_set_icon_hresult = $80004005;
	window_set_icon_context = global.s_window_set_icon_file_exists;
	return false;
}

var _buf = buffer_load(_path);
if (_buf == -1) {
	window_set_icon_hresult = $80004005;
	window_set_icon_context = global.s_window_set_icon_buffer_load;
	return false;
}
if (global.g_window_set_icon_buffer != -1) {
	buffer_delete(global.g_window_set_icon_buffer);
}
global.g_window_set_icon_path = _path;
global.g_window_set_icon_buffer = _buf;

return window_set_icon_buffer(_buf);

#define window_set_icon_buffer
/// (buffer_with_an_ico_inside)
var _buf = argument0;

//
var _arg = global.g_window_set_icon_argbuf;
if (_arg == -1) {
	_arg = buffer_create(128, buffer_fixed, 1);
	global.g_window_set_icon_argbuf = _arg;
}
buffer_seek(_arg, buffer_seek_start, 0);
buffer_write(_arg, buffer_u32, buffer_get_size(_buf));
buffer_write(_arg, buffer_u32, $80004005);
buffer_write(_arg, buffer_string, global.s_window_set_icon_dll_missing);

//
var _ok = window_set_icon_raw(window_handle(), buffer_get_address(_buf), buffer_get_address(_arg));
buffer_seek(_arg, buffer_seek_start, 4);
window_set_icon_hresult = buffer_read(_arg, buffer_u32);
window_set_icon_context = buffer_read(_arg, buffer_string);

return _ok;

#define window_reset_icon
/// ()
if (window_reset_icon_raw(window_handle())) {
	global.g_window_set_icon_path = undefined;
	window_set_icon_hresult = 0;
	window_set_icon_context = global.s_window_set_icon_all_good;
	return true;
} else {
	window_set_icon_hresult = $80004005;
	window_set_icon_context = global.s_window_set_icon_dll_missing;
	return false;
}

#define window_set_overlay_icon
/// (path_to_an_ico, description)
var _path = argument0, _desc = argument1;
//
if (_path == global.g_window_set_overlay_icon_path) {
	window_set_icon_hresult = 0;
	window_set_icon_context = global.s_window_set_icon_reuse;
	return true;
}

if (!file_exists(_path)) {
	window_set_icon_hresult = $80004005;
	window_set_icon_context = global.s_window_set_icon_file_exists;
	return false;
}

var _buf = buffer_load(_path);
if (_buf == -1) {
	window_set_icon_hresult = $80004005;
	window_set_icon_context = global.s_window_set_icon_buffer_load;
	return false;
}
if (global.g_window_set_overlay_icon_buffer != -1) {
	buffer_delete(global.g_window_set_overlay_icon_buffer);
}
global.g_window_set_overlay_icon_path = _path;
global.g_window_set_overlay_icon_buffer = _buf;
return window_set_overlay_icon_buffer(_buf, _desc);

#define window_set_overlay_icon_buffer
/// (buffer_with_an_ico_inside, description)
var _buf = argument0, _desc = argument1;

//
var _arg = global.g_window_set_icon_argbuf;
if (_arg == -1) {
	_arg = buffer_create(128, buffer_fixed, 1);
	global.g_window_set_icon_argbuf = _arg;
}
buffer_seek(_arg, buffer_seek_start, 0);
buffer_write(_arg, buffer_u32, buffer_get_size(_buf));
buffer_write(_arg, buffer_u32, $80004005);
buffer_write(_arg, buffer_string, global.s_window_set_icon_dll_missing);

//
var _ok = window_set_overlay_icon_raw(window_handle(), buffer_get_address(_buf), string(_desc), buffer_get_address(_arg));
buffer_seek(_arg, buffer_seek_start, 4);
window_set_icon_hresult = buffer_read(_arg, buffer_u32);
window_set_icon_context = buffer_read(_arg, buffer_string);

return _ok;

#define window_reset_overlay_icon
/// ()
if (window_reset_overlay_icon_raw(window_handle())) {
	global.g_window_set_overlay_icon_path = undefined;
	window_set_icon_hresult = 0;
	window_set_icon_context = global.s_window_set_icon_all_good;
	return true;
} else {
	window_set_icon_hresult = $80004005;
	window_set_icon_context = global.s_window_set_icon_dll_missing;
	return false;
}