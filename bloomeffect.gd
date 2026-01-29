@tool
extends CompositorEffect
class_name BloomEffect

const SHADER_TEMPLATE := """
shader_type canvas_item;

uniform sampler2D scene_tex : hint_albedo;
uniform float threshold = 1.0;
uniform float strength = 1.5;
uniform float radius = 4.0;
uniform vec2 resolution;

vec3 luminance(vec3 color) {
	return vec3(max(max(color.r, color.g), color.b)); // luminance (max RGB values)
}

void fragment() {
	vec2 texel = 1.0 / resolution;
	vec3 color = texture(scene_tex, UV).rgb;

	// 1. Apply threshold to extract bright areas
	float bright = luminance(color);
	if (bright < threshold) {
		color = vec3(0.0);  // Set non-bright areas to black
	}

	// 2. Simple blur (Box blur)
	vec3 blur = color;
	int r = int(radius);
	int count = 1;
	for (int y = -r; y <= r; y++) {
		for (int x = -r; x <= r; x++) {
			vec2 offset = vec2(x, y) * texel;
			blur += texture(scene_tex, UV + offset).rgb;
			count++;
		}
	}
	blur /= float(count);

	// 3. Combine the bloom effect
	color += blur * strength;

	// Output final color
	COLOR = vec4(color, 1.0);
}
"""

var _shader : Shader
var _material : ShaderMaterial

@export var threshold : float = 1.0
@export var strength  : float = 1.5
@export var radius    : float = 4.0

func _ready():
	# Initialize the shader and material
	_shader = Shader.new()
	_shader.source_code = SHADER_TEMPLATE
	_material = ShaderMaterial.new()
	_material.shader = _shader

	# Set parameters for the shader material (this is where parameters are applied)
	_material.set_shader_parameter("threshold", threshold)
	_material.set_shader_parameter("strength", strength)
	_material.set_shader_parameter("radius", radius)
	_material.set_shader_parameter("resolution", get_viewport().size)

	# Apply the material to the CompositorEffect
	material = _material

func _process(delta):
	# Update resolution dynamically if needed (for resizing, etc.)
	_material.set_shader_parameter("resolution", get_viewport().size)
