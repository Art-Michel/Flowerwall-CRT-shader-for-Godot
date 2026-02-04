extends OptionButton

@export var preblurx_sl: HSlider
@export var preblury_sl: HSlider
@export var bloom_t: HSlider
@export var bloom_i: HSlider
@export var smear_sl: HSlider
@export var scanlines_size_sl: HSlider
@export var scanlines_op_sl: HSlider
@export var scanlines_int_sl: HSlider
@export var grain_sl: HSlider
@export var wiggle_sl: HSlider
@export var curve_sl: HSlider
@export var grid: CheckButton
@export var slot: CheckButton
@export var mask_strength_sl: HSlider
@export var pixel_size_sl: HSlider

func _ready() -> void:
	connect("item_selected", _on_preset_selected)
	select(-1)

func _on_preset_selected(value:int) -> void:
	match value:
		0: # Subtle Slot
			preblurx_sl.value = 4.0
			preblury_sl.value = 2.0
			grain_sl.value = 0.05
			scanlines_size_sl.value = 1.0
			scanlines_op_sl.value = 0.25
			scanlines_int_sl.value = 3.0
			curve_sl.value = 1.0
			wiggle_sl.value = 0.00
			bloom_t.value = 0.05
			bloom_i.value = 0.7
			smear_sl.value = 0.2
			slot.button_pressed = true
			grid.button_pressed = false
			mask_strength_sl.value = 0.4
			pixel_size_sl.value = 3.0
	
		1: # Subtle Grid
			preblurx_sl.value = 4.0
			preblury_sl.value = 2.0
			grain_sl.value = 0.05
			scanlines_size_sl.value = 1.0
			scanlines_op_sl.value = 0.25
			scanlines_int_sl.value = 3.0
			curve_sl.value = 1.0
			wiggle_sl.value = 0.00
			bloom_t.value = 0.05
			bloom_i.value = 0.7
			smear_sl.value = 0.2
			slot.button_pressed = false
			grid.button_pressed = true
			mask_strength_sl.value = 0.4
			pixel_size_sl.value = 3.0
	
		2: # Medium slot
			preblurx_sl.value = 4.0
			preblury_sl.value = 2.0
			grain_sl.value = 0.05
			scanlines_size_sl.value = 2.0
			scanlines_op_sl.value = 0.20
			scanlines_int_sl.value = 3.0
			curve_sl.value = 1.0
			wiggle_sl.value = 0.00
			bloom_t.value = 0.05
			bloom_i.value = 0.7
			smear_sl.value = 0.3
			slot.button_pressed = true
			grid.button_pressed = false
			mask_strength_sl.value = 0.3
			pixel_size_sl.value = 4.0
	
		3: # Medium grid
			preblurx_sl.value = 4.0
			preblury_sl.value = 2.0
			grain_sl.value = 0.05
			scanlines_size_sl.value = 2.0
			scanlines_op_sl.value = 0.20
			scanlines_int_sl.value = 3.0
			curve_sl.value = 1.0
			wiggle_sl.value = 0.00
			bloom_t.value = 0.05
			bloom_i.value = 0.7
			smear_sl.value = 0.3
			slot.button_pressed = false
			grid.button_pressed = true
			mask_strength_sl.value = 0.3
			pixel_size_sl.value = 4.0
	
		4: # VHS
			preblurx_sl.value = 4.0
			preblury_sl.value = 2.0
			grain_sl.value = 0.35
			scanlines_size_sl.value = 3.0
			scanlines_op_sl.value = 0.2
			scanlines_int_sl.value = 6.0
			curve_sl.value = 1.025
			wiggle_sl.value = 0.05
			bloom_t.value = 0.05
			bloom_i.value = 0.6
			smear_sl.value = 0.6
			slot.button_pressed = false
			grid.button_pressed = false
			mask_strength_sl.value = 0.0
			pixel_size_sl.value = 3.0
	
		5: # Disabled
			preblurx_sl.value = 0.0
			preblury_sl.value = 0.0
			grain_sl.value = 0.0
			scanlines_size_sl.value = 0.0
			scanlines_op_sl.value = 0.0
			scanlines_int_sl.value = 0.0
			curve_sl.value = 1.00
			wiggle_sl.value = 0.00
			bloom_t.value = 0.0
			bloom_i.value = 0.0
			smear_sl.value = 0.0
			slot.button_pressed = false
			grid.button_pressed = false
			mask_strength_sl.value = 0.0
			pixel_size_sl.value = 3.0
			
