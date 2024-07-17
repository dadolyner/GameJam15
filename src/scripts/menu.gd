extends Control

@onready var start_button = $VBoxContainer/StartButton


# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.grab_focus()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/level_select.tscn") 
	

func _on_options_button_pressed():
	#To-Do Options menu
	get_tree().change_scene_to_file("res://src/scenes/options.tscn") 


func _on_quit_button_pressed():
	get_tree().quit()
