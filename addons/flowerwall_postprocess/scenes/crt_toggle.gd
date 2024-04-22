extends Button

func _ready() -> void:
	connect("toggled", flowerwall_pp_autoload._on_crt_toggled)
