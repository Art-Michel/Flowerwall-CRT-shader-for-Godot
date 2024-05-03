extends Control

@export var dither: CanvasLayer
@export var preblur_x: CanvasLayer
@export var preblur_y: CanvasLayer
@export var crt: CanvasLayer
@export var bloom: CanvasLayer

@onready var dither_shader: Material = dither.get_child(0).get_material()
@onready var crt_shader: Material= crt.get_child(0).get_material()
@onready var preblur_x_shader: Material= preblur_x.get_child(0).get_material()
@onready var preblur_y_shader: Material= preblur_y.get_child(0).get_material()
@onready var bloom_shader: Material= bloom.get_child(0).get_material()


func _on_dithering_toggled(value:bool) -> void:
	dither_shader.set("shader_parameter/dithering", value)
func _on_downscale_changed(value:float) -> void:
	dither_shader.set("shader_parameter/resolution_scale", value)
func _on_color_depth_changed(value:float) -> void:
	dither_shader.set("shader_parameter/color_depth", value)


func _on_preblur_toggled(value:bool) -> void:
	preblur_x.visible = value
	preblur_y.visible = value
func _on_preblur_changed(value:float) -> void:
	preblur_x_shader.set("shader_parameter/radius", value)
	preblur_y_shader.set("shader_parameter/radius", value)


func _on_grain_enabled(value:bool) -> void:
	crt_shader.set("shader_parameter/enable_grain", value)
func _on_grain_changed(value:float) -> void:
	crt_shader.set("shader_parameter/grain_strength", value)


func _on_scanlines_enabled(value:bool) -> void:
	crt_shader.set("shader_parameter/enable_scanlines", value)
func _on_scanlines_changed(value:float) -> void:
	crt_shader.set("shader_parameter/scanline_opacity", value)


func _on_curvature_enabled(value:bool) -> void:
	crt_shader.set("shader_parameter/enable_curving", value)
func _on_curvature_changed(value: float) -> void:
	crt_shader.set("shader_parameter/curve_power", value)


func _on_vignette_enabled(value:bool) -> void:
	crt_shader.set("shader_parameter/enable_vignette", value)
func _on_vignette_size_changed(value: float) -> void:
	crt_shader.set("shader_parameter/vignette_size", value)
func _on_vignette_smoothness_changed(value: float) -> void:
	crt_shader.set("shader_parameter/vignette_smoothness", value)


func _on_vhs_wiggle_enabled(value:bool) -> void:
	crt_shader.set("shader_parameter/enable_vhs_wiggle", value)
func _on_vhs_wiggle_strength_changed(value: float) -> void:
	crt_shader.set("shader_parameter/wiggle", value)


func _on_chromatic_aberration_enabled(value:bool) -> void:
	crt_shader.set("shader_parameter/enable_chromatic_aberration", value)
func _on_chromatic_aberration_changed(value:float) -> void:
	crt_shader.set("shader_parameter/chromatic_aberration_strength", value)


func _on_crt_toggled(value:bool) -> void:
	crt_shader.set("shader_parameter/enable_rgb_grid", value)
func _on_brightness_changed(value:float) -> void:
	crt_shader.set("shader_parameter/brightness_multiplier", value)


func _on_bloom_enabled(value:bool) -> void:
	bloom.visible = value
func _on_bloom_threshold_changed(value:float) -> void:
	bloom_shader.set("shader_parameter/bloom_threshold", value)
func _on_bloom_intensity_changed(value:float) -> void:
	bloom_shader.set("shader_parameter/bloom_intensity", value)
