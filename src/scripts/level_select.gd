extends Control
@onready var region_1_button = $Region1Button
@onready var region_2_button = $Region2Button
@onready var region_3_button = $Region3Button
@onready var region_4_button = $Region4Button
@onready var region_5_button = $Region5Button

# Called when the node enters the scene tree for the first time.
func _ready():
	region_1_button.disabled = false
	region_2_button.disabled = true
	region_3_button.disabled = true
	region_4_button.disabled = true
	region_5_button.disabled = true


func _on_region_1_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game.tscn") 
