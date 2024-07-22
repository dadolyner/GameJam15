extends Node2D

@export var current_region: int = 0
@export var next_region: bool = false
@export var current_level: int = 0
@export var flags: Array[Area2D]
@onready var timer = $Timer

var activated_flags: Array[Area2D] = []

func _ready() -> void:
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func add_activated_flag(flag: Area2D) -> void:
	if not activated_flags.has(flag):
		activated_flags.append(flag)
		
		if activated_flags.size() >= 2:
			timer.start()

func _on_timer_timeout() -> void:
	if next_region:
		current_region += 1
		current_level = 0
		get_tree().change_scene_to_file(Globals.regions[current_region].levels[0].scene)
	else:
		current_level += 1
		get_tree().change_scene_to_file(Globals.regions[current_region].levels[current_level].scene)
		
