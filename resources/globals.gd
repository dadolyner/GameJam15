extends Node

const menu: Dictionary = {
	"levels": "res://src/scenes/level_select.tscn",
	"options": "res://src/scenes/options.tscn",
	"back_to_menu": "res://src/scenes/menu.tscn"
}

const regions: Array[Dictionary] = [
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
		"name": "region_01",
		"scene": "res://src/scenes/game.tscn",
	},
]
