extends HSlider
@export var mytext:Label
@export var flowerwall_pp: flowerwallPP

func _ready() -> void:
	connect("value_changed", flowerwall_pp._on_color_depth_changed)
	connect("value_changed", _on_value_changed)
	value = flowerwall_pp.DITHERING_SHADER.get("shader_parameter/color_depth")
	mytext.text = str(value)
	
func _on_value_changed(a: float) -> void:
	mytext.text = str(a)
