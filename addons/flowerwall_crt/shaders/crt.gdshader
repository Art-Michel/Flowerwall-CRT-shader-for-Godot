shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;


group_uniforms grid_settings;
uniform bool enable_slotmask = true;
uniform bool enable_gridmask = true;
//uniform bool enable_dotmask = true;
uniform float mask_strength: hint_range(0, 1, 0.05) = 0.45;
uniform float pixel_size: hint_range(3, 6, 1) = 3;

group_uniforms grain_settings;
uniform bool enable_grain = true;
uniform float grain_strength: hint_range(0.0, 1.0, 0.05) = 0.25;

group_uniforms curving_settings;
uniform bool enable_curving = false;
uniform float curve_power: hint_range(1.0, 1.1, 0.005) =1.02;

group_uniforms scanlines_settings;
uniform bool enable_scanlines = true;
uniform float scanlines_interval: hint_range(0.0, 20.0, 1.0) = 3.0;
uniform float scanlines_opacity: hint_range(0, 1, 0.05) = 0.45;
uniform float scanlines_thickness: hint_range(0, 10, 1.0) = 1;

group_uniforms Smearing;
uniform bool enable_smearing = true;
uniform float smearing_strength : hint_range(0.0, 1.0, 0.1) = 0.2;
const int blur_samples = 6;

group_uniforms vhs_wiggle_settings;
uniform sampler2D noise_texture: filter_linear_mipmap, repeat_enable;
uniform bool enable_wiggle = true;
uniform float wiggle: hint_range(0.0, 0.2, 0.02) = 0.04;

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

float onOff(float a, float b, float c, float framecount) {
    return step(c, sin((framecount * 0.001) + a * cos((framecount * 0.001) * b)));
}

vec2 Circle(float Start, float Points, float Point) {
    float Rad = (3.141592 * 2.0 * (1.0 / Points)) * (Point + Start);
    return vec2(-(.3 + Rad), cos(Rad));
}

vec3 rgb2yiq(vec3 c) {
    return vec3(
        (0.2989 * c.x + 0.5959 * c.y + 0.2115 * c.z),
        (0.5870 * c.x - 0.2744 * c.y - 0.5229 * c.z),
        (0.1140 * c.x - 0.3216 * c.y + 0.3114 * c.z)
    );
}

vec3 yiq2rgb(vec3 c) {
    return vec3(
        (1.0 * c.x + 1.0 * c.y + 1.0 * c.z),
        (0.956 * c.x - 0.2720 * c.y - 1.1060 * c.z),
        (0.6210 * c.x - 0.6474 * c.y + 1.7046 * c.z)
    );
}

vec3 Blur(vec2 uv, float d, int samples) {
	vec3 sum = vec3(0.0);
	float W = 1.0 / float(samples);
	for (int i = 0; i < samples; ++i)
	{
		float t = (sin( 5.0 + uv.y * 5.0)) / 10.0;

		t = 0.0;
		vec2 PixelOffset = vec2(d + 0.0005 * t, 0);
        
		float Start = 2.0 / float(samples);
		vec2 Scale = 0.66 * 4.0 * 2.0 * PixelOffset.xy;
        
		vec3 N = texture(screen_texture, uv + Circle(Start, float(samples), float(i)) * Scale).rgb;
		sum += N * W;
    }
    return sum;
}

void fragment()
{
	vec2 xy = SCREEN_UV;

	if(enable_wiggle)
	{
		xy.x += (v2random(vec2(xy.y / 10.0, TIME / 100.0) / 1.0) - 0.5) * wiggle *0.1;
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
	
	if (enable_smearing)
	{
		//Source: https://godotshaders.com/shader/vhs/
		//By cyanone.art
		float s = 0.0001 * 0.0001;
		float e = min(.30,pow(max(0.0,cos(xy.y*4.0+.3)-.75)*(s+0.5)*1.0,3.0))*25.0;
		float r = (250.0*(2.0*s));

		float d = 0.051+abs(sin(s/4.0));
		float c = max(0.0001,.002*d) * smearing_strength;
		vec4 final;

		final.rgb = Blur(xy, c + c * xy.x, blur_samples);
		float y = rgb2yiq(final.rgb).r;

		xy.x += 0.01 * d;
		c *= 4.0;
		final.rgb = Blur(xy, c, blur_samples);
		float i = rgb2yiq(final.rgb).g;

		xy.x += 0.005 * d;
		c *= 2.50;
		final.rgb = Blur(xy, c, blur_samples);
		float q = rgb2yiq(final.rgb).b;
		final.rgb = yiq2rgb(vec3(y, i, q)) - pow(s + e * 2.0, 3.0);
		color.rgb = final.rgb;
	}

	if(enable_grain)
		color.rgb = mix(color.rgb ,vec3(0.0), filmGrainNoise(TIME, SCREEN_UV) * grain_strength);

	if(enable_gridmask)
	{
		int rgbIndex = int(FRAGCOORD.x) %int(pixel_size);
		if(rgbIndex == 0)
		{
			color.r *= 1.0;
			color.gb *= 1.0 - mask_strength;
		}
		else if(rgbIndex == 1)
		{ 
			color.g *= 1.0;
			color.rb *= 1.0 - mask_strength;
		}
		else if(rgbIndex == 2)
		{
			color.b *= 1.0;
			color.rg *= 1.0 - mask_strength;
		}
		else if(rgbIndex == 3)
		{
			color.rgb *= 1.0 - (mask_strength * 1.33);
		}
		
		if(enable_scanlines)
		{
			float scanline = mod(float(FRAGCOORD.y), pixel_size);
			scanline = 1.0 - (step(scanlines_thickness, scanline));
			scanline *= scanlines_opacity;
			color.rgb *= 1.- scanline;
		}
	}

	else if(enable_slotmask)
	{
		int lineIndex = int(FRAGCOORD.y) / int(pixel_size) % 4;
		//int lineIndex = 0;
		
		int rgbIndex = int(FRAGCOORD.x + float(lineIndex*2)) %4;
		if(rgbIndex == 0)
		{
			color.r *= 1.0;
			color.gb *= 1.0 - mask_strength;
		}
		else if(rgbIndex == 1)
		{ 
			color.g *= 1.0;
			color.rb *= 1.0 - mask_strength;
		}
		else if(rgbIndex == 2)
		{
			color.b *= 1.0;
			color.rg *= 1.0 - mask_strength;
		}
		else if(rgbIndex == 3)
		{
			color.rgb *= 1.0 - (mask_strength * 0.666);
		}
		if(enable_scanlines)
		{
			int colIndex = int(FRAGCOORD.x/3.) % 2;
			float scanline = mod(float(FRAGCOORD.y), pixel_size);
			scanline = 1.0 - (step(scanlines_thickness, scanline));
			scanline *= scanlines_opacity;
			color.rgb *= 1.- scanline;
		}
	}

	else if(enable_scanlines)
	{
			float scanline = mod(float(FRAGCOORD.y), scanlines_interval); // check which pixel we are in a row of X
			scanline = 1.0 - (step(scanlines_thickness, scanline)); // black if above 1.0 (0.0, 1.0, 2.0)
			scanline *= scanlines_opacity;
			color.rgb *= 1.- scanline;
	}

	if(enable_curving)
	{
		vec2 uv = SCREEN_UV;
		uv *=  1.0 - uv.yx;
		float vig = uv.x*uv.y / (curve_power-1.) * 120.0;
		vig = pow(vig, 1.0);
		color.rgb -= 1.0-(clamp(vig,0,1));
	}

	COLOR = color;
}