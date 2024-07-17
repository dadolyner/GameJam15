extends Control

@onready var start_button: Button = $VBoxContainer/StartButton

func _ready() -> void:
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(Globals.menu.levels)
	
func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file(Globals.menu.options)

func _on_options_button_pressed():
	#To-Do Options menu
	get_tree().change_scene_to_file("res://src/scenes/options.tscn") 


func _on_quit_button_pressed():
	get_tree().quit()
