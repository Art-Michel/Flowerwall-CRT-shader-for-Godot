extends OptionButton

@export var dither: CheckButton
@export var crt: CheckButton
@export var downscale: HSlider
@export var blur: HSlider
@export var noise: HSlider
@export var scanline: HSlider
@export var curve: HSlider
@export var brightness: HSlider
@export var bloom_t: HSlider
@export var bloom_i: HSlider

func _ready() -> void:
	connect("item_selected", _on_preset_selected)

func _on_preset_selected(value:int) -> void:
	match value:
		0: # High Res
			dither.button_pressed = false
			crt.button_pressed = false
			downscale.value = 1.0
			blur.value = 0.0
			noise.value = 0.0
			scanline.value = 0.0
			curve.value = 0.0
			brightness.value = 1.0
			bloom_t.value = 0.0
			bloom_i.value = 0.0
		1: # (Dithered, pixelated)
			dither.button_pressed = true
			crt.button_pressed = false
			downscale.value = 6.0
			blur.value = 0.0
			noise.value = 0.0
			scanline.value = 00.
			curve.value = 0.0
			brightness.value = 1.0
			bloom_t.value = 0.0
			bloom_i.value = 0.0
		2: # Sharp CRT (CRT Monitor)
			dither.button_pressed = false
			crt.button_pressed = true
			downscale.value = 1.0
			blur.value = 3.0
			noise.value = 0.0
			scanline.value = 0.5
			curve.value = 0.0
			brightness.value = 1.3
			bloom_t.value = 0.12
			bloom_i.value = 1.7
		3: # CRT TV (Blurry, Noisy)
			dither.button_pressed = false
			crt.button_pressed = true
			downscale.value = 1.0
			blur.value = 3.0
			noise.value = 0.3
			scanline.value = 0.4
			curve.value = 1.02
			brightness.value = 1.3
			bloom_t.value = 0.12
			bloom_i.value = 1.7
