if (!window_set_icon("yalSunglasses.ico")) {
	show_debug_message("Failed to set icon, HRESULT="
		+ string(window_set_icon_hresult)
		+ ", context: " + window_set_icon_context
	);
}