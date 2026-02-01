shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float bloom_threshold:hint_range(0.0, 1.0, 0.01) = 0.14;
uniform float bloom_intensity:hint_range(0.0, 3.0, 0.01) = 2.20;

uniform int bloom_blur_iterations: hint_range(1, 10, 1.0) = 5;
uniform float bloom_blur_size: hint_range(0, 0.01 , 0.001) = 0.002;
uniform int bloom_blur_subdivisions = 8;

vec3 getHDR(vec3 tex) {
    return max((tex - bloom_threshold) * bloom_intensity, vec3(0.0));
}

vec3 gaussian(sampler2D sampler, vec2 uv) {
    vec3 sum = vec3(0.0);

    for (int i = 1; i <= bloom_blur_iterations; i++) {
        float angle = 360.0 / float(bloom_blur_subdivisions);

        for (int j = 0; j < bloom_blur_subdivisions; j++) {
            float dist = bloom_blur_size * float(i + 1) / float(bloom_blur_iterations);
            float s = sin(angle * float(j));
            float c = cos(angle * float(j));

            sum += getHDR(texture(sampler, uv + vec2(c, s) * dist).xyz);
        }
    }

    sum /= float(bloom_blur_iterations * bloom_blur_subdivisions);
    return sum * bloom_intensity;
}

vec3 blend(vec3 a, vec3 b) {
    return 1.0 - (1.0 - a) * (1.0 - b);
}

void fragment() {
    vec4 tx = texture(screen_texture, SCREEN_UV);
    vec3 result = gaussian(screen_texture, SCREEN_UV);

	vec4 bg = vec4(result, 1);

    float gray = dot(bg.rgb, vec3(0.299, 0.587, 0.114));
    bg = vec4(bg.rgb, gray);

	vec4 final = bg;

	final = bg + tx;

    COLOR = final;
}