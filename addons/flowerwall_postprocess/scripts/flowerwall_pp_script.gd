class_name flowerwallPP
extends Control

@export var flowerwall_crt_config_ui: CanvasLayer
@export var dither: CanvasLayer
@export var preblur_x: CanvasLayer
@export var preblur_y: CanvasLayer
@export var post_bloom: CanvasLayer
@export var crt: CanvasLayer

const BLOOM_SHADER = preload("res://addons/flowerwall_postprocess/shaders/bloom_shader.material")
const BLURX_SHADER = preload("res://addons/flowerwall_postprocess/shaders/blurx_shader.material")
const BLURY_SHADER = preload("res://addons/flowerwall_postprocess/shaders/blury_shader.material")
const CRT_SHADER = preload("res://addons/flowerwall_postprocess/shaders/crt_shader.material")
const DITHERING_SHADER = preload("res://addons/flowerwall_postprocess/shaders/dithering_shader.material")

func _ready() -> void:
	should_enable_dither()
	should_enable_blur()
	should_enable_crt()
	should_enable_bloom()
	flowerwall_crt_config_ui.visible = false

#Open Menu
func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F1:
			flowerwall_crt_config_ui.visible = !flowerwall_crt_config_ui.visible

func should_enable_dither() -> void:
	if DITHERING_SHADER.get("shader_parameter/downscaling_strength") > 1.0: 
		dither.visible = true
		return
	if DITHERING_SHADER.get("shader_parameter/color_compression") > 0.0:
		dither.visible = true
		return
	dither.visible = false

func should_enable_blur() -> void:
	if BLURX_SHADER.get("shader_parameter/radius") > 0.0:
		preblur_x.visible = true
		preblur_y.visible = true
		return
	preblur_x.visible = false
	preblur_y.visible = false

func should_enable_crt() -> void:
	crt.visible = false
	if CRT_SHADER.get("shader_parameter/grain_strength") > 0.0:
		CRT_SHADER.set("shader_parameter/enable_grain", true)
		crt.visible = true
	else:
		
		CRT_SHADER.set("shader_parameter/enable_grain", false)
	if CRT_SHADER.get("shader_parameter/scanline_opacity") > 0.0:
		CRT_SHADER.set("shader_parameter/enable_scanlines", true)
		crt.visible = true
	else:
		
		CRT_SHADER.set("shader_parameter/enable_scanlines", false)
	if CRT_SHADER.get("shader_parameter/vignette_size") > 0.1:
		CRT_SHADER.set("shader_parameter/enable_vignette", true)
		crt.visible = true
	else:
		
		CRT_SHADER.set("shader_parameter/enable_vignette", false)
	if CRT_SHADER.get("shader_parameter/wiggle") > 0.0:
		CRT_SHADER.set("shader_parameter/enable_vhs_wiggle", true)
		crt.visible = true
	else:
		
		CRT_SHADER.set("shader_parameter/enable_vhs_wiggle", false)
	if CRT_SHADER.get("shader_parameter/curve_power") > 1.0:
		CRT_SHADER.set("shader_parameter/enable_curving", true)
		crt.visible = true
	else:
		
		CRT_SHADER.set("shader_parameter/enable_curving", false)
	if CRT_SHADER.get("shader_parameter/chromatic_aberration_strength") > 0.0:
		CRT_SHADER.set("shader_parameter/enable_chromatic_aberration", true)
		crt.visible = true
	else:
		CRT_SHADER.set("shader_parameter/enable_chromatic_aberration", false)
		
	if CRT_SHADER.get("shader_parameter/enable_rgb_grid") == true:
		crt.visible = true
	if CRT_SHADER.get("shader_parameter/brightness_multiplier") > 1.00:
		crt.visible = true

func should_enable_bloom() -> void:
	if BLOOM_SHADER.get("shader_parameter/bloom_intensity") > 0.0: 
		post_bloom.visible = true
		return
	post_bloom.visible = false


#region Signals

func _on_downscale_slider_value_changed(value: float) -> void:
	DITHERING_SHADER.set("shader_parameter/downscaling_strength", value)
	should_enable_dither()


func _on_color_depth_slider_value_changed(value: float) -> void:
	DITHERING_SHADER.set("shader_parameter/color_compression", value)
	should_enable_dither()


func _on_blur_slider_value_changed(value: float) -> void:
	BLURY_SHADER.set("shader_parameter/radius", value)
	BLURX_SHADER.set("shader_parameter/radius", value)
	should_enable_blur()


func _on_brightness_modifier_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/brightness_multiplier", value)


func _on_bloom_intensity_slider_value_changed(value: float) -> void:
	BLOOM_SHADER.set("shader_parameter/bloom_intensity", value)
	should_enable_bloom()


func _on_bloom_threshold_slider_value_changed(value: float) -> void:
	BLOOM_SHADER.set("shader_parameter/bloom_threshold", value)
	should_enable_bloom()


func _on_chroma_aberr_strength_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/chromatic_aberration_strength", value)
	should_enable_crt()


func _on_rgb_grid_toggle_toggled(toggled_on: bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_rgb_grid", toggled_on)
	should_enable_crt()


func _on_scanlines_opacity_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/scanline_opacity", value)
	should_enable_crt()

func _on_scanlines_size_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/scanline_thickness", value)
	CRT_SHADER.set("shader_parameter/scanlines_interval", value *2)
	should_enable_crt()

func _on_grain_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/grain_strength", value)
	should_enable_crt()


func _on_vhs_wiggle_strength_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/wiggle", value)
	should_enable_crt()


func _on_vignette_size_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/vignette_size", value)
	should_enable_crt()


func _on_vignette_smoothness_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/vignette_smoothness", value)
	should_enable_crt()


func _on_curvature_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/curve_power", value)
	should_enable_crt()

#endregion
