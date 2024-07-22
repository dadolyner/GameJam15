extends Node2D

@export var coin_collection: Array[Area2D]
@onready var pickup_sound: AudioStreamPlayer = $PickupSound
@onready var fail_sound: AudioStreamPlayer = $FailSound
@export var player1_speech_bubble: CharacterBody2D
@export var player2_speech_bubble: CharacterBody2D

var current_speaker: CharacterBody2D
var fail_attempts: int = 3
var is_in_order: bool = false
var coin_index: int = 0

func pickup_coin(coin: Area2D, body: Node) -> void:
	if not is_in_order and coin == coin_collection[0]:
		is_in_order = true
		coin_index += 1
		pickup_sound.play()
		coin.set_collision_mask_value(2, 0)
		coin.get_node("AnimatedSprite2D").play("explosion")
	else:
		if coin == coin_collection[coin_index]:
			coin_index += 1
			pickup_sound.play()
			coin.set_collision_mask_value(2, 0)
			coin.get_node("AnimatedSprite2D").play("explosion")
			if coin_index == len(coin_collection):
				GameManager.add_points(100)
		else:
			current_speaker = body
			reset_coins(body)

func reset_coins(body: Node) -> void:
	fail_attempts -= 1
	if fail_attempts == 0:
		if body == player1_speech_bubble:
			Signals.triggers_chat_coin_puzzle.emit(player1_speech_bubble)
		else:
			Signals.triggers_chat_coin_puzzle.emit(player2_speech_bubble)

	for coin in coin_collection:
		coin.visible = true
		coin.set_collision_mask_value(2, 3)
		coin.get_node("AnimatedSprite2D").play("idle")
	is_in_order = false
	coin_index = 0
	fail_sound.play()
