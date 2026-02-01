extends Button

@export var preblur_x_mat: ColorRect
@export var preblur_y_mat: ColorRect
@export var crt_mat: ColorRect
@export var bloom_mat: ColorRect

func _pressed() -> void:
	ResourceSaver.save(preblur_x_mat.material, "res://addons/flowerwall_crt/shaders/blurx_shader.material")
	ResourceSaver.save(preblur_y_mat.material, "res://addons/flowerwall_crt/shaders/blury_shader.material")
	ResourceSaver.save(crt_mat.material, "res://addons/flowerwall_crt/shaders/crt_shader.material")
	ResourceSaver.save(bloom_mat.material, "res://addons/flowerwall_crt/shaders/bloom_shader.material")
	return
