# window_set_icon
**Quick links:** [itch.io page](https://yellowafterlife.itch.io/window-set-icon)

This small extension allows you to dynamically change
window icon (also seen in taskbar)
and taskbar badges (commonly used for notifications and such)
in your projects.

**Functions (GameMaker):**

* **window_set_icon(path_to_ico)**  
	Changes the window icon. Path should point to a valid ICO file.
* **window_set_icon_buffer(buffer_with_an_ico_inside)**  
	Changes the window icon. The buffer should contain a valid ICO file.
* **window_set_icon_surface(surface, set_big_icon)**  
	Changes the window icon to match the pixels in a surface.  
	"big" (32x32) icon may used for display in taskbar.
* **window_reset_icon()**  
	Resets the window icon to whatever it was on game start.
* **window_set_overlay_icon(path_to_ico, ?description)**  
	Changes the little overlay/notification badge icon shown in the corner of the window. Path should point to a valid ICO file.
* **window_set_overlay_icon_buffer(buffer_with_an_ico_inside, ?description)**  
	Changes the little overlay/notification badge icon shown in the corner of the taskbar button. The buffer should contain a valid ICO file.
* **window_set_overlay_icon_surface(surface, ?description)**  
	Changes the little overlay/notification badge icon shown in the corner of the taskbar button to match pixels in a surface.
* **window_reset_overlay_icon()**  
	Resets/removes the little overlay/notification badge icon.

So, for example, if you had a "some.ico" in your Included Files, you could do
```
window_set_icon("some.ico");
```

**Functions (C#):**

* **WindowIconTools.SetIcon(texture2d or null, kind)**  
	Changes small or big icon for the window to match the given texture with format=BGRA32.  
	In non-Unity C#, you provide an array of bgra bytes, width, and height instead of a texture.
* **WindowIconTools.SetOverlayIcon(texture2d or null, opt. description)**  
	Changes the overlay icon in the taskbar.
* **WindowIconTools.SetProgress(progressState, numCompleted, numTotal)**  
	This is an equivalent of the [other extension I made](https://yellowafterlife.itch.io/window-progress) and is only here because it didn't really "cost" anything to add.

Have fun!
