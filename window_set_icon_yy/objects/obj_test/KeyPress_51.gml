if (!window_set_overlay_icon("test.ico", "Test!")) {
	show_debug_message("Failed to set overlay icon, HRESULT="
		+ string(window_set_icon_hresult)
		+ ", context: " + window_set_icon_context
	);
}