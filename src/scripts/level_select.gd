extends Control

@export var regions: Array[TextureButton]

func _ready() -> void:
	for r in len(Globals.regions):
		var current_region = Globals.regions[r]
		regions[r].disabled = current_region.disabled
			
func _on_region_1_button_pressed() -> void:
	get_tree().change_scene_to_file(Globals.regions[1].levels[0].scene)


func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file(Globals.regions[0].levels[0].scene)
