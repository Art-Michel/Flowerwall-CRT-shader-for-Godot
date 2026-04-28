extends HSlider

func _ready() -> void:
	value = 1/ get_viewport().scaling_3d_scale
