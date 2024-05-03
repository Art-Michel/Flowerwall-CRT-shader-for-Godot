extends OptionButton

@export var dither: CheckButton
@export var color_depth: HSlider
@export var downscale: HSlider

@export var preblur: CheckButton
@export var preblur_sl: HSlider

@export var grain: CheckButton
@export var grain_sl: HSlider

@export var scanlines: CheckButton
@export var scanlines_sl: HSlider

@export var curve: CheckButton
@export var curve_sl: HSlider

@export var vignette: CheckButton
@export var vignette_size_sl: HSlider
@export var vignette_smoothness_sl: HSlider

@export var wiggle: CheckButton
@export var wiggle_sl: HSlider

@export var chromaberr: CheckButton
@export var chromaberr_sl: HSlider

@export var rgb_grid: CheckButton
@export var brightness: HSlider

@export var bloom: CheckButton
@export var bloom_t: HSlider
@export var bloom_i: HSlider

func _ready() -> void:
	connect("item_selected", _on_preset_selected)
	select(-1)

func _on_preset_selected(value:int) -> void:
	match value:
		0: # High Res
			dither.button_pressed = false
			color_depth.value = 8
			downscale.value = 1.0

			preblur.button_pressed = false
			preblur_sl.value = 0.0

			grain.button_pressed = false
			grain_sl.value = 0.0

			scanlines.button_pressed = false
			scanlines_sl.value = 0.0

			curve.button_pressed = false
			curve_sl.value = 1.0

			vignette.button_pressed = false;
			vignette_size_sl.value = 0.1
			vignette_smoothness_sl.value = 0.05

			wiggle.button_pressed = false
			wiggle_sl.value = 0.0

			chromaberr.button_pressed = false
			chromaberr_sl.value = 0.0

			rgb_grid.button_pressed = false
			brightness.value = 1.0

			bloom.button_pressed = false
			bloom_t.value = 0.0
			bloom_i.value = 0.0

		1: # (Dithered, pixelated)
			dither.button_pressed = true
			color_depth.value = 4
			downscale.value = 5.0

			preblur.button_pressed = false
			preblur_sl.value = 0.0

			grain.button_pressed = false
			grain_sl.value = 0.0

			scanlines.button_pressed = false
			scanlines_sl.value = 0.0

			curve.button_pressed = false
			curve_sl.value = 1.0

			vignette.button_pressed = false;
			vignette_size_sl.value = 0.1
			vignette_smoothness_sl.value = 0.05

			wiggle.button_pressed = false
			wiggle_sl.value = 0.0

			chromaberr.button_pressed = false
			chromaberr_sl.value = 0.0

			rgb_grid.button_pressed = false
			brightness.value = 1.0

			bloom.button_pressed = false
			bloom_t.value = 0.0
			bloom_i.value = 0.0

		2: # Sharp CRT (CRT Monitor)
			dither.button_pressed = false
			color_depth.value = 8
			downscale.value = 1.0

			preblur.button_pressed = true
			preblur_sl.value = 3.0

			grain.button_pressed = false
			grain_sl.value = 0.0

			scanlines.button_pressed = true
			scanlines_sl.value = 0.6

			curve.button_pressed = false
			curve_sl.value = 1.00

			vignette.button_pressed = false;
			vignette_size_sl.value = 0.1
			vignette_smoothness_sl.value = 0.05

			wiggle.button_pressed = false
			wiggle_sl.value = 0.02

			chromaberr.button_pressed = true
			chromaberr_sl.value = 1.0

			rgb_grid.button_pressed = true
			brightness.value = 1.

			bloom.button_pressed = true
			bloom_t.value = 0.14
			bloom_i.value = 2.1

		3: # CRT TV (Blurry, Noisy)
			dither.button_pressed = false
			color_depth.value = 8
			downscale.value = 1.0

			preblur.button_pressed = true
			preblur_sl.value = 5.0

			grain.button_pressed = true
			grain_sl.value = 0.25

			scanlines.button_pressed = true
			scanlines_sl.value = 0.45

			curve.button_pressed = true
			curve_sl.value = 1.03

			vignette.button_pressed = true;
			vignette_size_sl.value = 0.4
			vignette_smoothness_sl.value = 0.4

			wiggle.button_pressed = true
			wiggle_sl.value = 0.02

			chromaberr.button_pressed = true
			chromaberr_sl.value = 1.0

			rgb_grid.button_pressed = true
			brightness.value = 1.05

			bloom.button_pressed = true
			bloom_t.value = 0.14
			bloom_i.value = 2.2

		4: # VHS Tape (
			dither.button_pressed = false
			color_depth.value = 5
			downscale.value = 4.0

			preblur.button_pressed = true
			preblur_sl.value = 4

			grain.button_pressed = true
			grain_sl.value = 0.4

			scanlines.button_pressed = true
			scanlines_sl.value = 0.15

			curve.button_pressed = false
			curve_sl.value = 1.0

			vignette.button_pressed = false;
			vignette_size_sl.value = 0.1
			vignette_smoothness_sl.value = 0.05

			wiggle.button_pressed = true
			wiggle_sl.value = 0.07

			chromaberr.button_pressed = true
			chromaberr_sl.value = 3

			rgb_grid.button_pressed = false
			brightness.value = 1.0

			bloom.button_pressed = true
			bloom_t.value = 0.14
			bloom_i.value = 0.8
