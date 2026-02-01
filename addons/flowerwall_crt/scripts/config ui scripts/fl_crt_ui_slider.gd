extends HSlider

@export var _mat: ShaderMaterial
@export var _var: String

func _ready() -> void:
	value = _mat.get(_var)
