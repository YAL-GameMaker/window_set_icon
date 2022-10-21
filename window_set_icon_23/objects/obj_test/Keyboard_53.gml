for (var i = 0; i < 3; i++) {
	var sf = icon_surfaces[i];
	var sz = icon_surface_sizes[i];
	if (!surface_exists(sf)) {
		sf = surface_create(sz, sz);
		icon_surfaces[i] = sf;
	}
	var ov = (i == 2), col;
	surface_set_target(sf);
	if (ov) {
		col = make_color_hsv((current_time / 10) % 256, 150, 170);
	} else {
		col = make_color_hsv((current_time / 10) % 256, 250, 230);
	}
	draw_clear(col);
	draw_sprite(spr_debug, i, 0, 0);
	surface_reset_target();
	if (ov) {
		window_set_overlay_icon_surface(icon_surfaces[2]);
	} else window_set_icon_surface(sf, i);
}
