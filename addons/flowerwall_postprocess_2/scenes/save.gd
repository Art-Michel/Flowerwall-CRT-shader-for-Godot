extends Button

@export var dithering_mat: ColorRect
@export var preblur_x_mat: ColorRect
@export var preblur_y_mat: ColorRect
@export var crt_mat: ColorRect
@export var bloom_mat: ColorRect

func _pressed() -> void:
	ResourceSaver.save(dithering_mat.material, "res://addons/flowerwall_postprocess/shaders/dithering_shader.material")
	ResourceSaver.save(preblur_x_mat.material, "res://addons/flowerwall_postprocess/shaders/blurx_shader.material")
	ResourceSaver.save(preblur_y_mat.material, "res://addons/flowerwall_postprocess/shaders/blury_shader.material")
	ResourceSaver.save(crt_mat.material, "res://addons/flowerwall_postprocess/shaders/crt_shader.material")
	ResourceSaver.save(bloom_mat.material, "res://addons/flowerwall_postprocess/shaders/bloom_shader.material")
	return
