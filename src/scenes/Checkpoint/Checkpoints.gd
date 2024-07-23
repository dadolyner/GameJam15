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
		Globals._set_current_region(current_region + 1)
		Globals._set_current_level(0)
		Globals._load_scene()
	else:
		Globals._set_current_level(current_level + 1)
		Globals._load_scene()
		
