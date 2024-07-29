extends Control

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var video_stream_player: VideoStreamPlayer = $IntroVideo/VideoStreamPlayer
@onready var margin_container: MarginContainer = $MarginContainer
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var skip_button: Button = $SkipButton

func _ready() -> void:
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	margin_container.visible = false
	v_box_container.visible = false
	skip_button.visible = true
	video_stream_player.play()
	
func _on_tutorial_button_pressed() -> void:
	Globals._set_current_region(0)
	Globals._set_current_level(0)
	Globals._load_scene()
	
func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file(Globals.menu.options)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_video_stream_player_finished():
	Globals._set_current_region(1)
	Globals._set_current_level(0)
	Globals._load_scene()

func _on_skip_button_pressed():
	skip_button.visible = false
	Globals._set_current_region(1)
	Globals._set_current_level(0)
	Globals._load_scene()
