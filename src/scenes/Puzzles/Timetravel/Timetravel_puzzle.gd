extends Node2D

@export var pineapple_collection: Array[Area2D]
@onready var countdown_timer = $countdown_timer
@onready var pickup_sound = $Pickup_sound

var has_already_timetraveled: bool = false
var has_timetravel_puzzle_started: bool = false
var time_needed_to_finish: float
var player1_start_positions
var player2_start_positions
var amount_of_objects: int = 0

var countup_timer := 0.0
var is_timer_active : bool = false

var was_faster: bool = false

var end_of_timetravel_chat_shown: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "end_of_start_of_timetravel":
		is_timer_active = true
	if argument == "end_of_timetravel":
		time_needed_to_finish = countup_timer
		countdown_timer.start(time_needed_to_finish)

		
func _process(delta):
	if is_timer_active:
		countup_timer += delta


func start_timetravel(player1, player2, pineapple):
	if not has_timetravel_puzzle_started:
		Dialogic.start("timetravel_start_chat")
		has_timetravel_puzzle_started = true
		player1_start_positions = player1.position
		player2_start_positions = player2.position
		pineapple.visible = false
		pineapple.set_collision_mask_value(2, 0)
		pickup_sound.play()
		amount_of_objects += 1	
	elif has_timetravel_puzzle_started and not has_already_timetraveled:
		amount_of_objects += 1
		pineapple.visible = false
		pineapple.set_collision_mask_value(2, 0)
		pickup_sound.play()
		if amount_of_objects == len(pineapple_collection):
			is_timer_active = false
			player1.position = player1_start_positions
			player2.position = player2_start_positions
			has_already_timetraveled = true
			reset_pineapples_for_timetravel()
	elif has_timetravel_puzzle_started and has_already_timetraveled:
		amount_of_objects += 1
		pineapple.visible = false
		pineapple.set_collision_mask_value(2, 0)
		pickup_sound.play()
		if amount_of_objects == len(pineapple_collection):	
			#To-Do, what happens when you win/lose
			if countdown_timer.time_left > 0:
				was_faster = true
				print("CONGRATS, YOU WIN")
			else: 
				was_faster = false
				print("LOOOOSEEEEEEEEEER")
			
func reset_pineapples_for_timetravel():
	if not end_of_timetravel_chat_shown:
		Dialogic.start("timetravel_reveal")
		end_of_timetravel_chat_shown = true
	amount_of_objects = 0
	for i in range(0,len(pineapple_collection)):
		pineapple_collection[i].visible = true
		pineapple_collection[i].set_collision_mask_value(2, 1)
