extends Button
@onready var ui: CanvasLayer = $"../.."

func _pressed() -> void:
	ui.visible = !ui.visible
