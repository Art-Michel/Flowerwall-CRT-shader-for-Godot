@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("flowerwall_pp_autoload", "res://addons/flowerwall_postprocess/scenes/flowerwall_pp.tscn")
	pass


func _exit_tree():
	remove_autoload_singleton("flowerwall_pp_autoload")
	pass
