extends OptionButton

@export var color_compression: HSlider
@export var downscale: HSlider
@export var preblur_sl: HSlider
@export var grain_sl: HSlider
@export var scanlines_size_slider: HSlider
@export var scanlines_sl: HSlider
@export var curve_sl: HSlider
@export var vignette_size_sl: HSlider
@export var vignette_smoothness_sl: HSlider
@export var wiggle_sl: HSlider
@export var chromaberr_sl: HSlider
@export var brightness: HSlider
@export var bloom_t: HSlider
@export var bloom_i: HSlider
@export var rgb: CheckButton

func _ready() -> void:
	connect("item_selected", _on_preset_selected)
	select(-1)

func _on_preset_selected(value:int) -> void:
	match value:
		0: # High Res
			color_compression.value = 0
			downscale.value = 1.0
			preblur_sl.value = 0.0
			grain_sl.value = 0.0
			scanlines_sl.value = 0.0
			scanlines_size_slider.value = 0.0
			curve_sl.value = 1.0
			vignette_size_sl.value = 0.1
			vignette_smoothness_sl.value = 0.05
			wiggle_sl.value = 0.0
			chromaberr_sl.value = 0.0
			brightness.value = 1.0
			bloom_t.value = 0.0
			bloom_i.value = 0.0
			rgb.button_pressed = false

		1: # (Dithered, pixelated)
			color_compression.value = 3
			downscale.value = 5.0
			preblur_sl.value = 0.0
			grain_sl.value = 0.0
			scanlines_sl.value = 0.0
			scanlines_size_slider.value = 0.0
			curve_sl.value = 1.0
			vignette_size_sl.value = 0.1
			vignette_smoothness_sl.value = 0.05
			wiggle_sl.value = 0.0
			chromaberr_sl.value = 0.0
			brightness.value = 1.0
			bloom_t.value = 0.0
			bloom_i.value = 0.0
			rgb.button_pressed = false

		2: # Sharp CRT (CRT Monitor)
			color_compression.value = 0
			downscale.value = 1.0
			preblur_sl.value = 2.0
			grain_sl.value = 0.1
			scanlines_sl.value = 0.6
			scanlines_size_slider.value = 2.0
			curve_sl.value = 1.00
			vignette_size_sl.value = 0.1
			vignette_smoothness_sl.value = 0.05
			wiggle_sl.value = 0.00
			chromaberr_sl.value = 0.0
			brightness.value = 1.2
			bloom_t.value = 0.14
			bloom_i.value = 2.0
			rgb.button_pressed = true

		3: # CRT TV (Blurry, Noisy)
			color_compression.value = 0
			downscale.value = 1.0
			preblur_sl.value = 5.0
			grain_sl.value = 0.25
			scanlines_sl.value = 0.45
			scanlines_size_slider.value = 1.0
			curve_sl.value = 1.03
			vignette_size_sl.value = 0.4
			vignette_smoothness_sl.value = 0.4
			wiggle_sl.value = 0.02
			chromaberr_sl.value = 1.0
			brightness.value = 1.3
			bloom_t.value = 0.2
			bloom_i.value = 1.9
			rgb.button_pressed = true

		4: # VHS Tape
			color_compression.value = 3
			downscale.value = 2.0
			preblur_sl.value = 4
			grain_sl.value = 0.4
			scanlines_sl.value = 0.15
			scanlines_size_slider.value = 4.0
			curve_sl.value = 1.0
			vignette_size_sl.value = 0.1
			vignette_smoothness_sl.value = 0.05
			wiggle_sl.value = 0.07
			chromaberr_sl.value = 4
			brightness.value = 1.0
			bloom_t.value = 0.14
			bloom_i.value = 0.1
			rgb.button_pressed = false

		5: #Artoria's prefered preset
			color_compression.value = 0
			downscale.value = 0.0
			preblur_sl.value = 3.0
			grain_sl.value = 0.2
			scanlines_sl.value = 0.4
			scanlines_size_slider.value = 3.0
			curve_sl.value = 1.0
			vignette_size_sl.value = 0.1
			vignette_smoothness_sl.value = 0.05
			wiggle_sl.value = 0.00
			chromaberr_sl.value = 0.0
			brightness.value = 1.2
			bloom_t.value = 0.16
			bloom_i.value = 1.9
			rgb.button_pressed = true
