class_name flowerwallPP
extends Control

@export var flowerwall_crt_config_ui: CanvasLayer
@export var preblur_x: CanvasLayer
@export var preblur_y: CanvasLayer
@export var post_bloom: CanvasLayer
@export var crt: CanvasLayer


const BLOOM_SHADER = preload("res://addons/flowerwall_postprocess/shaders/bloom_shader.material")
const BLURX_SHADER = preload("res://addons/flowerwall_postprocess/shaders/blurx_shader.material")
const BLURY_SHADER = preload("res://addons/flowerwall_postprocess/shaders/blury_shader.material")
const CRT_SHADER = preload("res://addons/flowerwall_postprocess/shaders/crt_shader.material")
const DITHERING_SHADER = preload("res://addons/flowerwall_postprocess/shaders/dithering_shader.material")

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F1:
			flowerwall_crt_config_ui.visible = !flowerwall_crt_config_ui.visible

func _input(event: InputEvent) -> void:
	if event is InputEventAction:
		if event.pressed and event.action == "crt_menu":
			flowerwall_crt_config_ui.visible = !flowerwall_crt_config_ui.visible

func _on_dithering_toggled(value:bool) -> void:
	DITHERING_SHADER.set("shader_parameter/dithering", value)
func _on_downscale_changed(value:float) -> void:
	DITHERING_SHADER.set("shader_parameter/resolution_scale", value)
func _on_color_depth_changed(value:float) -> void:
	DITHERING_SHADER.set("shader_parameter/color_depth", value)


func _on_preblur_toggled(value:bool) -> void:
	preblur_x.visible = value
	preblur_y.visible = value
func _on_preblur_changed(value:float) -> void:
	BLURX_SHADER.set("shader_parameter/radius", value)
	BLURY_SHADER.set("shader_parameter/radius", value)


func _on_grain_enabled(value:bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_grain", value)
func _on_grain_changed(value:float) -> void:
	CRT_SHADER.set("shader_parameter/grain_strength", value)


func _on_scanlines_enabled(value:bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_scanlines", value)
func _on_scanlines_changed(value:float) -> void:
	CRT_SHADER.set("shader_parameter/scanline_opacity", value)


func _on_curvature_enabled(value:bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_curving", value)
func _on_curvature_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/curve_power", value)


func _on_vignette_enabled(value:bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_vignette", value)
func _on_vignette_size_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/vignette_size", value)
func _on_vignette_smoothness_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/vignette_smoothness", value)


func _on_vhs_wiggle_enabled(value:bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_vhs_wiggle", value)
func _on_vhs_wiggle_strength_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/wiggle", value)


func _on_chromatic_aberration_enabled(value:bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_chromatic_aberration", value)
func _on_chromatic_aberration_changed(value:float) -> void:
	CRT_SHADER.set("shader_parameter/chromatic_aberration_strength", value)


func _on_crt_toggled(value:bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_rgb_grid", value)
func _on_brightness_changed(value:float) -> void:
	CRT_SHADER.set("shader_parameter/brightness_multiplier", value)


func _on_bloom_enabled(value:bool) -> void:
	post_bloom.visible = value
func _on_bloom_threshold_changed(value:float) -> void:
	BLOOM_SHADER.set("shader_parameter/bloom_threshold", value)
func _on_bloom_intensity_changed(value:float) -> void:
	BLOOM_SHADER.set("shader_parameter/bloom_intensity", value)


#func _on_visibility_changed() -> void:
	#flowerwall_crt_config_ui.visible = is_visible_in_tree()
	#preblur_x.visible = is_visible_in_tree()
	#preblur_y.visible = is_visible_in_tree()
	#crt.visible = is_visible_in_tree()
	#post_bloom.visible = is_visible_in_tree()
	#pass # Replace with function body.
