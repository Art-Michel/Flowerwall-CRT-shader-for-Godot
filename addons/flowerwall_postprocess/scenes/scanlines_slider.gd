extends HSlider
@export var mytext:Label

func _ready() -> void:
	connect("value_changed", flowerwall_pp_autoload._on_scanlines_changed)
	connect("value_changed", _on_value_changed)
	value = flowerwall_pp_autoload.crt_shader.get("shader_parameter/scanline_opacity")
	mytext.text = str(value)

func _on_value_changed(a: float) -> void:
	mytext.text = str(a)
