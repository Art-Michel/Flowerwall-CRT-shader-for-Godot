@tool
extends EditorPlugin

func _enter_tree():
	print_debug("mario!")
	InputMap.add_action("crt_menu")
	var ev = InputEventKey.new()
	ev.keycode = KEY_F1
	InputMap.action_add_event("crt_menu", ev)

func _exit_tree():
	InputMap.erase_action("crt_menu")
	pass
