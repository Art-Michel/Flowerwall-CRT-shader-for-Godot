shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform bool enable_grain = true;
uniform bool enable_curving = false;
uniform bool enable_scanlines = true;
uniform bool enable_chromatic_aberration = true;
uniform bool enable_rgb_grid = true;
uniform bool enable_vhs_wiggle = true;
uniform bool enable_vignette = false;
uniform float brightness_multiplier:hint_range(0.7,2.0, 0.01) = 1.05;

group_uniforms grain_settings;
uniform float grain_strength: hint_range(0.0, 1.0, 0.05) = 0.25;

group_uniforms curving_settings;
uniform float curve_power: hint_range(1.0, 1.05, 0.005) =1.02;

group_uniforms vignette_settings;
uniform float vignette_size: hint_range(0.1, 10.0, 0.1) = 0.4;
uniform float vignette_smoothness: hint_range(0.05, 5.0, 0.05) = 0.4;

group_uniforms scanlines_settings;
uniform float scanlines_interval: hint_range(0.0, 20.0, 1.0) = 6.0;
uniform float scanline_opacity: hint_range(0, 1, 0.05) = 0.45;
uniform float scanline_thickness: hint_range(0, 10, 1.0) = 3;

group_uniforms chromatic_aberration_settings;
uniform float chromatic_aberration_strength: hint_range(0.0, 10.0, 1.0) = 1.0;


group_uniforms vhs_wiggle_settings;
uniform sampler2D noise_texture: filter_linear_mipmap, repeat_enable;
uniform float wiggle:hint_range(0.0, 0.05, 0.001) = 0.002;

vec2 distort(vec2 p) 
{
	float angle = p.y / p.x;
	float theta = atan(p.y,p.x);
	float radius = pow(length(p), curve_power);
	
	p.x = radius * cos(theta);
	p.y = radius * sin(theta);
	
	return 0.5 * (p + vec2(1.0,1.0));
}

float filmGrainNoise(in float time, in vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233) * time)) * 43758.5453);
}

float v2random(vec2 uv) {
	return texture(noise_texture, mod(uv, vec2(1.0))).x;
}

void fragment()
{
	vec2 xy = SCREEN_UV;
	
	if(enable_vhs_wiggle)
	{
		xy.x += (v2random(vec2(xy.y / 10.0, TIME / 10.0) / 1.0) - 0.5) * wiggle *0.1;
		xy.x += (v2random(vec2(xy.y, TIME * 10.0)) - 0.5) * wiggle * 0.1;
	}
	
	if(enable_curving)
	{
		xy *= 2.0;
		xy.x -= 1.0;
		xy.y -= 1.0;
		xy = distort(xy);
	}
	
	vec4 color = texture(screen_texture, xy);
	
	if(enable_chromatic_aberration)
	{
		float r = texture(screen_texture, xy + vec2(SCREEN_PIXEL_SIZE*vec2(chromatic_aberration_strength, 0.0)), 0.0).r;
		float g = texture(screen_texture, xy + vec2(SCREEN_PIXEL_SIZE* 0.0), 0.0).g;
		float b = texture(screen_texture, xy + vec2(SCREEN_PIXEL_SIZE*vec2(-chromatic_aberration_strength, 0.0)), 0.0).b;
		color.rgb = vec3(r, g, b);
	}
	
	if(enable_grain)
		color.rgb = mix(color.rgb ,vec3(0.0), filmGrainNoise(TIME, SCREEN_UV) * grain_strength);
	
	if(enable_rgb_grid)
	{
		float r;
		float g;
		float b;
		int rgbIndex = int(FRAGCOORD.x) % 3;
		if(rgbIndex == 0)
			r = 1.;
		else
			r = 0.;
		if(rgbIndex == 1)
			g = 1.;
		else
			g = 0.;
		if(rgbIndex == 2)
			b = 1.;
		else
			b = 0.;
		vec3 mask = vec3(r,g,b);
		color.rgb *= mask;
	}
	color.rgb *= brightness_multiplier;
	
	if(enable_scanlines)
	{
		float scanline = mod(float(FRAGCOORD.y), scanlines_interval); // check which pixel we are in a row of X
		scanline = 1.0 - (step(scanline_thickness, scanline)); // black if above 1.0 (0.0, 1.0, 2.0)
		scanline *= scanline_opacity;
		color.rgb *= 1.- scanline;
	}
	
	if(enable_vignette)
	{
		vec2 uv = SCREEN_UV;
		uv *=  1.0 - uv.yx;
		float vig = uv.x*uv.y / vignette_size * 1000.0; 
		vig = pow(vig, 1.0/vignette_smoothness);
		color.rgb -= 1.0-(clamp(vig,0,1));
	}
	
	COLOR = color;
}