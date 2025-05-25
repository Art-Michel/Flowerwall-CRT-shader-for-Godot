extends HSlider
@export var mytext:Label
@export var flowerwall_pp: flowerwallPP

func _ready() -> void:
	connect("value_changed", flowerwall_pp._on_brightness_changed)
	connect("value_changed", _on_value_changed)
	value = flowerwall_pp.CRT_SHADER.get("shader_parameter/brightness_multiplier")
	mytext.text = str(value)
	
func _on_value_changed(a: float) -> void:
	mytext.text = str(a)
