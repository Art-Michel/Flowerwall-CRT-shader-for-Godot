extends Button
@export var mytext:Label
@export var flowerwall_pp: flowerwallPP

func _ready() -> void:
	connect("toggled", flowerwall_pp._on_crt_toggled)
	connect("toggled", _on_value_changed)
	button_pressed = flowerwall_pp.CRT_SHADER.get("shader_parameter/enable_rgb_grid")
	mytext.text = str(button_pressed)
	
func _on_value_changed(a: bool) -> void:
	mytext.text = str(a)
