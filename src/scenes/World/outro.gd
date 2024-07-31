extends Control

func _on_video_stream_player_finished():
	get_tree().change_scene_to_file(Globals.menu.back_to_menu)


func _on_skip_button_pressed():
	get_tree().change_scene_to_file(Globals.menu.back_to_menu)
