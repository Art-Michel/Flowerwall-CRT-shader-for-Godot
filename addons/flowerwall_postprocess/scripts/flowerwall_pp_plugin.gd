@tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("flowerwall_crt", "res://addons/flowerwall_postprocess/scenes/flowerwall_pp.tscn")
	print_debug("flowerwall crt shader enabled")

func _exit_tree():
	remove_autoload_singleton("flowerwall_crt")
	print_debug("flowerwall crt shader removed")
