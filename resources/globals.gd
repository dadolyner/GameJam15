extends Node

const menu: Dictionary = {
	"levels": "res://src/scenes/World/level_select.tscn",
	"options": "res://src/scenes/options.tscn",
	"back_to_menu": "res://src/scenes/menu.tscn"
}

var current_region: int = 0
var current_level: int = 0

var current_player: int = 0

const regions: Array[Dictionary] = [
	{
		"name" : "tutorial",
		"levels": tutorial_level,
		"disabled": false
	},
	{
		"name" : "region_one",
		"levels": region_one_levels,
		"disabled": false
	},
	{
		"name": "region_two",
		"levels": {},
		"disabled": true
	},
	{
		"name": "region_three",
		"levels": {},
		"disabled": true
	},
	{
		"name": "region_four",
		"levels": {},
		"disabled": true
	},
	{
		"name": "region_five",
		"levels": {},
		"disabled": true
	}
] 

const region_one_levels: Array[Dictionary] = [
	{	
		"name": "level_01",
		"scene": "res://src/scenes/World/level_01.tscn"
	},
	{	
		"name": "level_02",
		"scene": "res://src/scenes/World/level_02.tscn"
	},
	{	
		"name": "level_03",
		"scene": "res://src/scenes/World/level_03.tscn"
	}
]

const tutorial_level: Array[Dictionary] = [
	{	
		"name": "level_01",
		"scene": "res://src/scenes/World/tutorial.tscn",
	}
]

func _set_current_region(region: int) -> void:
	current_region = region
	
func _set_current_level(level: int) -> void:
	current_level = level

func _load_scene() -> void:
	get_tree().change_scene_to_file(Globals.regions[current_region].levels[current_level].scene)

func _shift_players() -> void:
	if current_player == 0:
		current_player = 1
	else:
		current_player = 0
