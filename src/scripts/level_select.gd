extends Control

@export var regions: Array[TextureButton]

func _ready() -> void:
	for r in len(Globals.regions):
		var current_region = Globals.regions[r]
		regions[r].disabled = current_region.disabled
			
func _on_region_1_button_pressed() -> void:
	Globals._set_current_region(1)
	Globals._set_current_level(0)
	Globals._load_scene()

func _on_tutorial_button_pressed():
	Globals._set_current_region(0)
	Globals._set_current_level(0)
	Globals._load_scene()
