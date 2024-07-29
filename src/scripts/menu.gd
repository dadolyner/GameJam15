extends Control

@onready var start_button: Button = $VBoxContainer/StartButton

func _ready() -> void:
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	Globals._set_current_region(1)
	Globals._set_current_level(0)
	Globals._load_scene()
	
func _on_tutorial_button_pressed() -> void:
	Globals._set_current_region(0)
	Globals._set_current_level(0)
	Globals._load_scene()
	
func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file(Globals.menu.options)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
