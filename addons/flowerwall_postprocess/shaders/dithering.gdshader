shader_type canvas_item;

//Shader courtesy of sagokoliknet!!

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float color_compression : hint_range(0.0, 7.0, 1.0) = 0.0;
//uniform bool dithering = false;
uniform float downscaling_strength:hint_range(1.0, 32.0, 1.0) = 1.0;

int dithering_pattern(ivec2 fragcoord) {
    const int pattern[] = {
        -4, +0, -3, +1,
        +2, -2, +3, -1,
        -3, +1, -4, +0,
        +3, -1, +2, -2
    };

    int x = fragcoord.x % 4;
    int y = fragcoord.y % 4;

    return pattern[y * 4 + x];
}

void fragment() {
    ivec2 uv = ivec2(FRAGCOORD.xy / float(downscaling_strength));
    vec3 color = texelFetch(screen_texture, uv * int(downscaling_strength), 0).rgb;

    // Convert from 0 to 1 to 0 to 255.
    ivec3 c = ivec3(round(color * 255.0));

    // Apply the dithering.
    //if (dithering) {
        c += ivec3(dithering_pattern(uv));
    //}

    // Truncate from 8 bits to color_compression bits.
    c >>= (int(color_compression));

    // Convert back to 0 to 1.
    COLOR.rgb = vec3(c) / float(1 << 8- int(color_compression));
}