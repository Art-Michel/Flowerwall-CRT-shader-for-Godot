extends HSlider
@export var mytext:Label

func _ready() -> void:
	connect("value_changed", flowerwall_pp_autoload._on_downscale_changed)
	connect("value_changed", _on_value_changed)
	value = flowerwall_pp_autoload.dither_shader.get("shader_parameter/resolution_scale")
	mytext.text = str(value)
	
func _on_value_changed(a: float) -> void:
	mytext.text = str(a)
