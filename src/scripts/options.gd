extends Control

@onready var volume_power: Label  = $VBoxContainer/HBoxContainer2/VolumePower
@onready var h_slider: HSlider = $VBoxContainer/HBoxContainer2/HSlider
@export var start_value: int = 30

func _ready() -> void:
	h_slider.value = start_value


func _on_h_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(0, value * 0.25)
	volume_power.text = str(value)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Globals.menu.back_to_menu)
