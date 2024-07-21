extends Node2D

@export var pineapple_collection: Array[Area2D]
@onready var countdown_timer: Timer = $countdown_timer
@onready var pickup_sound: AudioStreamPlayer = $Pickup_sound
@onready var player_1_label: Label = $Player_1_Label
@onready var player_2_label: Label = $Player_2_Label

@export var players: Array[CharacterBody2D]

var has_already_timetraveled: bool = false
var has_timetravel_puzzle_started: bool = false
var time_needed_to_finish: float
var player_1_start_positions: Vector2
var player_2_start_positions: Vector2
var amount_of_objects: int = 0

var countup_timer: float = 0.0
var is_timer_active: bool = false
var was_faster: bool = false

func round_place(num,places):
	return (round(num * pow(10, places)) / pow(10, places))
		
func _process(delta):
	if is_timer_active:
		countup_timer += delta
	if not countdown_timer.is_stopped():
		player_1_label.position = players[0].position + Vector2(0, -32)
		player_2_label.position = players[1].position + Vector2(0, -32)
		player_1_label.text = str(round_place(countdown_timer.time_left, 2))
		player_2_label.text = str(round_place(countdown_timer.time_left, 2))
	else:
		player_1_label.text = ""
		player_2_label.text = ""

func start_timetravel(pineapple: Area2D):
	if not has_timetravel_puzzle_started:
		start_puzzle(pineapple)
	elif has_timetravel_puzzle_started and not has_already_timetraveled:
		continue_puzzle(pineapple)
	elif has_timetravel_puzzle_started and has_already_timetraveled:
		finish_puzzle(pineapple)
			
func start_puzzle(pineapple: Area2D):
	is_timer_active = true
	has_timetravel_puzzle_started = true
	player_1_start_positions = players[0].position
	player_2_start_positions = players[1].position
	handle_pineapple_pickup(pineapple)
	amount_of_objects += 1

func continue_puzzle(pineapple: Area2D):
	handle_pineapple_pickup(pineapple)
	amount_of_objects += 1
	if amount_of_objects == pineapple_collection.size():
		is_timer_active = false
		players[0].position = player_1_start_positions
		players[1].position = player_2_start_positions
		time_needed_to_finish = countup_timer
		countdown_timer.start(time_needed_to_finish)
		has_already_timetraveled = true
		reset_pineapples_for_timetravel()

func finish_puzzle(pineapple: Area2D):
	handle_pineapple_pickup(pineapple)
	amount_of_objects += 1
	if amount_of_objects == pineapple_collection.size():
		if countdown_timer.time_left > 0:
			was_faster = true
			countdown_timer.stop()
			player_1_label.text = ""
			player_2_label.text = ""
			print("CONGRATS, YOU WIN")
		else:
			was_faster = false
			print("LOOOOSEEEEEEEEEER")

func handle_pineapple_pickup(pineapple: Area2D):
	pineapple.visible = false
	pineapple.set_collision_mask_value(2, 0)
	pickup_sound.play()

func reset_pineapples_for_timetravel():
	amount_of_objects = 0
	for pineapple in pineapple_collection:
		pineapple.visible = true
		pineapple.set_collision_mask_value(2, 1)
