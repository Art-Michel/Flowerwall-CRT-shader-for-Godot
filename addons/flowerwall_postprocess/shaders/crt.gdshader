shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float noise_strength: hint_range(0.0, 1.0, 0.05) = 0.3;

uniform float curve_power: hint_range(1.0, 1.05, 0.005) =1.02;
uniform float vignette_size: hint_range(0.1, 10.0, 0.1) = 6.0;
uniform float vignette_attenuation: hint_range(0.05, 5.0, 0.05) = 2.0;

uniform float scanlines_interval:hint_range(0.0, 20.0, 1.0) = 6.0;
uniform float scanline_opacity: hint_range(0, 1, 0.05) = 0.45;
uniform float scanline_thickness: hint_range(0, 10, 1.0) = 3;


uniform float brightness_multiplier:hint_range(0.7,2.0, 0.01) = 1.2;

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

void fragment()
{
	//curvature
	vec4 color = texture(screen_texture, SCREEN_UV);
	vec2 xy = SCREEN_UV * 2.0;
	xy.x -= 1.0;
	xy.y -= 1.0;
	
	float d = length(xy);
	if(d < 1.5){
		xy = distort(xy);
	}
	else{
		xy = SCREEN_UV;
	}
	color = texture(screen_texture, xy);
	//curvature end
	
	//noise
	color.rgb = mix(color.rgb ,vec3(0.0), filmGrainNoise(TIME, SCREEN_UV) * noise_strength);
	//noise end
	
	//mask
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
	color.rgb = color.rgb * mask * brightness_multiplier;
	//mask end
	
	//scanlines
	float scanline = mod(float(FRAGCOORD.y), scanlines_interval); // check which pixel we are in a row of X
	scanline = 1.0 - (step(scanline_thickness, scanline)); // black if above 1.0 (0.0, 1.0, 2.0)
	scanline *= scanline_opacity;
	color.rgb *= 1.- scanline;
	//scanlines end
	
	//vignette
	vec2 uv = SCREEN_UV;
	uv *=  1.0 - uv.yx;   //vec2(1.0)- uv.yx; -> 1.-u.yx; Thanks FabriceNeyret !
	float vig = uv.x*uv.y * vignette_size * 1000.0; // multiply with sth for intensityvig = pow(vig, 0.25); // change pow for modifying the extend of the  vignette
	vig = pow(vig, vignette_attenuation);
	color.rgb -= 1.0-(clamp(vig,0,1));
	//vignette end
	
	COLOR = color;
}