extends Node

var is_timer_running = false

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var miliseconds: int = 0

var timer_props: Dictionary = {
	miliseconds: 0,
	seconds: 0,
	minutes: 0
}

func _process(delta) -> void:
	if is_timer_running == false:
		return
	
	time += delta
	miliseconds = int(fmod(time, 1) * 100)
	seconds = int(fmod(time, 60))
	minutes = int(fmod(time, 3600) / 60)
	
func start_timer() -> void:
	is_timer_running = true
	
func stop_timer() -> void:
	is_timer_running = false

func get_timer_props() -> Dictionary:
	timer_props.miliseconds = miliseconds
	timer_props.seconds = seconds
	timer_props.minutes = minutes
	return timer_props
