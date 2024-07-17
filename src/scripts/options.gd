extends Control

@onready var volume_power = $VBoxContainer/HBoxContainer2/VolumePower
@onready var h_slider = $VBoxContainer/HBoxContainer2/HSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	h_slider.value = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0,value)
	volume_power.text = str(value)


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/menu.tscn") 
