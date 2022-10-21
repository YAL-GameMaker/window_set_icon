# window_set_icon

**Quick links:** [itch.io](https://yellowafterlife.itch.io/window-set-icon)

This small extension allows you to dynamically change window icon (also seen in taskbar) and taskbar badges (commonly used for notifications and such) in your GameMaker games.

## Functions (GameMaker)

- **window_set_icon(path_to_ico)**  
	Changes the window icon. Path should point to a valid ICO file.
- **window_set_icon_buffer(buffer_with_an_ico_inside)**  
	Changes the window icon. The buffer should contain a valid ICO file.
- **window_set_icon_surface(surface, set_big_icon)**  
	Changes the window icon to match the pixels in a surface.  
	"big" (32x32) icon may used for display in taskbar.
- **window_reset_icon()**  
	Resets the window icon to whatever it was on game start.
- **window_set_overlay_icon(path_to_ico, ?description)**  
	Changes the little overlay/notification badge icon shown in the corner of the window. Path should point to a valid ICO file.
- **window_set_overlay_icon_buffer(buffer_with_an_ico_inside, ?description)**  
	Changes the little overlay/notification badge icon shown in the corner of the taskbar button. The buffer should contain a valid ICO file.
- **window_set_overlay_icon_surface(surface, ?description)**  
	Changes the little overlay/notification badge icon shown in the corner of the taskbar button to match pixels in a surface.
- **window_reset_overlay_icon()**  
	Resets/removes the little overlay/notification badge icon.

So, for example, if you had a "some.ico" in your Included Files, you could do
```gml
window_set_icon("some.ico");
```

## Functions (C#)

- **WindowIconTools.SetIcon(texture2d or null, kind)**  
	Changes small or big icon for the window to match the given texture with format=BGRA32.  
	In non-Unity C#, you provide an array of bgra bytes, width, and height instead of a texture.  
- **WindowIconTools.SetOverlayIcon(texture2d or null, opt. description)**  
	Changes the overlay icon in the taskbar.
- **WindowIconTools.SetProgress(progressState, numCompleted, numTotal)**  
	This is an equivalent of the other extension I made and is only here because it didn't really "cost" anything to add.  

## Preparing to build

Needless to say, this requires basic familiarity with Visual Studio, Command Prompt/PowerShell, and Windows in general.

### Setting up GmxGen

1. [Install Haxe](https://haxe.org/download/) (make sure to install Neko VM!)
2. [Download the source code](https://github.com/YAL-GameMaker-Tools/GmxGen/archive/refs/heads/master.zip) 
(or [check out the git repository](https://github.com/YAL-GameMaker-Tools/GmxGen))
3. Compile the program: `haxe build.hxml`
4. Create an executable: `nekotools boot bin/GmxGen.n`
5. Copy `bin/GmxGen.exe` to a folder your PATH (e.g. to Haxe directory )

### Setting up GmlCppExtFuncs

1. (you should still have Haxe and Neko VM installed)
2. [Download the source code](https://github.com/YAL-GameMaker-Tools/GmlCppExtFuncs/archive/refs/heads/master.zip) 
(or [check out the git repository](https://github.com/YAL-GameMaker-Tools/GmlCppExtFuncs))
3. Compile the program: `haxe build.hxml`
4. Create an executable: `nekotools boot bin/GmlCppExtFuncs.n`
5. Copy `bin/GmlCppExtFuncs.exe` to a folder your PATH (e.g. to Haxe directory )

## Building

Open the `.sln` in Visual Studio (VS2019 was used as of writing this), compile for x86 - Release and then x64 - Release.

If you have correctly set up `GmxGen` and `GmlCppExtFuncs`,
the project will generate the `autogen.gml` files for GML<->C++ interop during pre-build
and will copy and [re-]link files during post-build.

## Meta

**Author:** [YellowAfterlife](https://github.com/YellowAfterlife)  
**License:** MIT