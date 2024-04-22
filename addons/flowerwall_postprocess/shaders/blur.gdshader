shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Radius that the shader was designed for.
const float DEFAULT_RADIUS = 9.000000000;

// Unit vector: (1, 0) or (0, 1)
uniform vec2 step;
// Desired blur radius.
uniform float radius = 3.000000000;

void fragment() {
	vec2 s = radius / DEFAULT_RADIUS * step / vec2(textureSize(screen_texture, 0));
	COLOR.rgb =
		0.012425302 * texture(screen_texture, SCREEN_UV - 9.000000000 * s).rgb +
		0.046287410 * texture(screen_texture, SCREEN_UV - 7.408451530 * s).rgb +
		0.087268415 * texture(screen_texture, SCREEN_UV - 5.432513128 * s).rgb +
		0.135364297 * texture(screen_texture, SCREEN_UV - 3.456897372 * s).rgb +
		0.172748950 * texture(screen_texture, SCREEN_UV - 1.481489944 * s).rgb +
		0.181383322 * texture(screen_texture, SCREEN_UV + 0.493827474 * s).rgb +
		0.156693587 * texture(screen_texture, SCREEN_UV + 2.469174944 * s).rgb +
		0.111371271 * texture(screen_texture, SCREEN_UV + 4.444671945 * s).rgb +
		0.065125981 * texture(screen_texture, SCREEN_UV + 6.420435068 * s).rgb +
		0.031331465 * texture(screen_texture, SCREEN_UV + 8.396575836 * s).rgb;
	COLOR.a = 1.0;
}
