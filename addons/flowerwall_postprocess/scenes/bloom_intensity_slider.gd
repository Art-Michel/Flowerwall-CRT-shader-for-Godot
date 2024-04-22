extends HSlider

func _ready() -> void:
	connect("value_changed", flowerwall_pp_autoload._on_bloom_intensity_changed)
