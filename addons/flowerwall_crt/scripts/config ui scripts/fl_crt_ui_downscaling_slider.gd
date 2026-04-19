extends HSlider

func _ready() -> void:
	value = ProjectSettings.get_setting("rendering/scaling_3d/scale")
