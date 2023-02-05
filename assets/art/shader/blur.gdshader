shader_type canvas_item;
render_mode blend_mix;

uniform int blur_count = 32;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	vec2 ps = TEXTURE_PIXEL_SIZE;
	
	
	int count = 0;
	for (int level = 1; level > 0; level++) {
		float x_from = UV.x - float(level) * ps.x;
		float x_to = UV.x + float(level) * ps.x;
		float y_from = UV.y - float(level) * ps.y;
		float y_to = UV.y + float(level) * ps.y;
		int times = 2 * level;
		float x_step = (x_to - x_from) / float(times);
		float y_step = (y_to - y_from) / float(times);
		for (int x_time = 0; x_time <= times; x_time++) {
			for (int y_time = 0; y_time <= times; y_time++) {
				float x = x_from + x_step * float(x_time);
				float y = y_from + y_step * float(y_time);
				col += texture(TEXTURE, vec2(x, y));
				count += 1;
				if (count >= blur_count) break;
			}
			if (count >= blur_count) break;
		}
		if (count >= blur_count) break;
	}
	col /= float(blur_count + 1);
	COLOR = col;
}
