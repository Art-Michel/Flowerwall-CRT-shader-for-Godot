extends Button
@export var mytext:Label

func _ready() -> void:
	connect("toggled", flowerwall_pp_autoload._on_bloom_enabled)
	connect("toggled", _on_value_changed)
	button_pressed = flowerwall_pp_autoload.bloom.visible
	mytext.text = str(button_pressed)
	
func _on_value_changed(a: bool) -> void:
	mytext.text = str(a)
