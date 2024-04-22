extends MeshInstance3D

@export_range(-1,2,0.1) var speed: float
@export_range(-1,1,0.05) var amplitude: float
var initial_pos: Vector3

func _ready() -> void:
	initial_pos = position

func _process(delta: float) -> void:
	position.y = initial_pos.y + sin(Time.get_ticks_msec() *0.001 * speed) * amplitude
	rotation.y = Time.get_ticks_msec() *0.001 * speed
