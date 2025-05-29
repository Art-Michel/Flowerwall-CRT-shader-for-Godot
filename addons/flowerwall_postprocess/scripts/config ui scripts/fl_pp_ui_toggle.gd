extends CheckButton

@export var _mat: ShaderMaterial
@export var _var: String

func _ready() -> void:
	button_pressed = _mat.get(_var)
