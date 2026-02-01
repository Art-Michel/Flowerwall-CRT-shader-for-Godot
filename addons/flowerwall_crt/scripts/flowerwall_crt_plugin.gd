@tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("flowerwall_crt", "res://addons/flowerwall_crt/scenes/flowerwall_crt.tscn")
	print_debug("flowerwall crt shader enabled")

func _exit_tree():
	remove_autoload_singleton("flowerwall_crt")
	print_debug("flowerwall crt shader removed")
