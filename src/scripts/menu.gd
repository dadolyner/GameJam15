extends Control

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var video_stream_player = $VideoStreamPlayer
@onready var margin_container = $MarginContainer
@onready var v_box_container = $VBoxContainer
@onready var skip_button = $SkipButton

func _ready() -> void:
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	margin_container.visible = false
	v_box_container.visible = false
	skip_button.visible = true
	video_stream_player.play()
	
func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file(Globals.menu.options)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_video_stream_player_finished():
	get_tree().change_scene_to_file(Globals.menu.levels)

func _on_skip_button_pressed():
	skip_button.visible = false
	get_tree().change_scene_to_file(Globals.menu.levels)
