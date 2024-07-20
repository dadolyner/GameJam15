extends Node2D

@export var pineapple_collection: Array[Area2D]
@onready var countdown_timer = $countdown_timer
@onready var pickup_sound = $Pickup_sound
@onready var time_left_label = $time_left_label
@export var playerOverheadPlayer: CharacterBody2D

var has_already_timetraveled: bool = false
var has_timetravel_puzzle_started: bool = false
var time_needed_to_finish: float
var player1_start_positions
var player2_start_positions
var amount_of_objects: int = 0

var countup_timer := 0.0
var is_timer_active : bool = false

var was_faster: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))
		
func _process(delta):
	if is_timer_active:
		countup_timer += delta
		print(countup_timer)
	if not countdown_timer.is_stopped():
		time_left_label.position.x = playerOverheadPlayer.position.x
		time_left_label.position.y = playerOverheadPlayer.position.y - 32
		time_left_label.text = str(round_place(countdown_timer.time_left,2))
	else:
		time_left_label.text = ""

func start_timetravel(player1, player2, pineapple):
	if not has_timetravel_puzzle_started:
		is_timer_active = true
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
			time_needed_to_finish = countup_timer
			countdown_timer.start(time_needed_to_finish)
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
	amount_of_objects = 0
	for i in range(0,len(pineapple_collection)):
		pineapple_collection[i].visible = true
		pineapple_collection[i].set_collision_mask_value(2, 1)
