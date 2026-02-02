class_name flowerwallCRT
extends Control

@export var flowerwall_crt_config_ui: CanvasLayer
@export var preblur_x: CanvasLayer
@export var preblur_y: CanvasLayer
@export var post_bloom: CanvasLayer
@export var crt: CanvasLayer

@export var grid_toggle: CheckButton
@export var slot_toggle: CheckButton
@export var scanlines_size_slider: HSlider
@export var scanlines_interval_slider: HSlider
var is_enabled: float = true

const BLOOM_SHADER = preload("res://addons/flowerwall_crt/shaders/bloom_shader.material")
const BLURX_SHADER = preload("res://addons/flowerwall_crt/shaders/blurx_shader.material")
const BLURY_SHADER = preload("res://addons/flowerwall_crt/shaders/blury_shader.material")
const CRT_SHADER = preload("res://addons/flowerwall_crt/shaders/crt_shader.material")

func _ready() -> void:
	should_enable_blur()
	should_enable_crt()
	should_enable_bloom()
	flowerwall_crt_config_ui.visible = false


#Menu
func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F1 and is_enabled and OS.is_debug_build():
			flowerwall_crt_config_ui.visible = !flowerwall_crt_config_ui.visible
		if event.pressed and event.keycode == KEY_F2 and OS.is_debug_build():
			enable_shader()

func enable_shader() -> void:
	if (is_enabled):
		is_enabled = false
		for n in get_children():
			n.visible = false
	else:
		is_enabled = true
		should_enable_blur()
		should_enable_crt()
		should_enable_bloom()

func should_enable_blur() -> void:
	if BLURX_SHADER.get("shader_parameter/radius") > 0.0:
		preblur_x.visible = true
	else: 
		preblur_x.visible = false
	if BLURY_SHADER.get("shader_parameter/radius") > 0.0:
		preblur_y.visible = true
	else: 
		preblur_y.visible = false

func should_enable_crt() -> void:
	crt.visible = false
	if CRT_SHADER.get("shader_parameter/grain_strength") > 0.0:
		CRT_SHADER.set("shader_parameter/enable_grain", true)
		crt.visible = true
	else:
		CRT_SHADER.set("shader_parameter/enable_grain", false)

	if CRT_SHADER.get("shader_parameter/scanlines_opacity") > 0.0:
		CRT_SHADER.set("shader_parameter/enable_scanlines", true)
		crt.visible = true
	else:
		CRT_SHADER.set("shader_parameter/enable_scanlines", false)

	if CRT_SHADER.get("shader_parameter/wiggle") > 0.0:
		CRT_SHADER.set("shader_parameter/enable_wiggle", true)
		crt.visible = true
	else:
		CRT_SHADER.set("shader_parameter/enable_wiggle", false)

	if CRT_SHADER.get("shader_parameter/curve_power") > 1.0:
		CRT_SHADER.set("shader_parameter/enable_curving", true)
		crt.visible = true
	else:
		CRT_SHADER.set("shader_parameter/enable_curving", false)

	if CRT_SHADER.get("shader_parameter/smearing_strength") > 0.0:
		CRT_SHADER.set("shader_parameter/enable_smearing", true)
		crt.visible = true
	else:
		CRT_SHADER.set("shader_parameter/enable_smearing", false)

	if CRT_SHADER.get("shader_parameter/enable_gridmask") == true:
		crt.visible = true
	if CRT_SHADER.get("shader_parameter/enable_slotmask") == true:
		crt.visible = true

func should_enable_bloom() -> void:
	if BLOOM_SHADER.get("shader_parameter/bloom_intensity") > 0.0: 
		post_bloom.visible = true
		return
	post_bloom.visible = false


#region Signals


func _on_blurx_slider_value_changed(value: float) -> void:
	BLURX_SHADER.set("shader_parameter/radius", value)
	should_enable_blur()

func _on_blury_slider_value_changed(value: float) -> void:
	BLURY_SHADER.set("shader_parameter/radius", value)
	should_enable_blur()

func _on_bloom_intensity_slider_value_changed(value: float) -> void:
	BLOOM_SHADER.set("shader_parameter/bloom_intensity", value)
	should_enable_bloom()

func _on_bloom_threshold_slider_value_changed(value: float) -> void:
	BLOOM_SHADER.set("shader_parameter/bloom_threshold", value)
	should_enable_bloom()


func _on_smearing_strength_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/smearing_strength", value)
	should_enable_crt()


func _on_gridmask_toggle_toggled(toggled_on: bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_gridmask", toggled_on)
	if slot_toggle.toggled:
		slot_toggle.set_pressed_no_signal(false)
		CRT_SHADER.set("shader_parameter/enable_slotmask", false)
	should_enable_crt()

func _on_slotmask_toggle_toggled(toggled_on: bool) -> void:
	CRT_SHADER.set("shader_parameter/enable_slotmask", toggled_on)
	if grid_toggle.toggled:
		grid_toggle.set_pressed_no_signal(false)
		CRT_SHADER.set("shader_parameter/enable_gridmask", false)
	should_enable_crt()


func _on_scanlines_opacity_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/scanlines_opacity", value)
	should_enable_crt()

func _on_scanlines_size_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/scanlines_thickness", value)
	if scanlines_interval_slider.value <= value:
		scanlines_interval_slider.set_value_no_signal(value+1)
		CRT_SHADER.set("shader_parameter/scanlines_interval", value+1)
	pass
	should_enable_crt()
	
func _on_scanlines_interval_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/scanlines_interval", value)
	if scanlines_size_slider.value >= value:
		scanlines_size_slider.set_value_no_signal(value-1)
		CRT_SHADER.set("shader_parameter/scanlines_thickness", value-1)
	should_enable_crt()

func _on_grain_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/grain_strength", value)
	should_enable_crt()


func _on_wiggle_strength_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/wiggle", value)
	should_enable_crt()


func _on_curvature_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/curve_power", value)
	should_enable_crt()

func _on_mask_strength_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/mask_strength", value)
	should_enable_crt()

func _on_pixel_size_slider_value_changed(value: float) -> void:
	CRT_SHADER.set("shader_parameter/pixel_size", value)
	should_enable_crt()
#endregion
