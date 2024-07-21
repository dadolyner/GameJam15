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

const lines_for_fail: Array[String] = [
	"Maybe I should collect them in the correct order..."
]


#To-Do: Display over the character that triggered it
func _process(delta):
	if current_speaker == player1_speech_bubble:
		DialogManager.update_position(player1_speech_bubble.position)
	elif current_speaker == player2_speech_bubble:
		DialogManager.update_position(player2_speech_bubble.position)
		
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
		else:
			current_speaker = body
			reset_coins(body)

func reset_coins(body: Node) -> void:
	fail_attempts -= 1
	if fail_attempts == 0:
		if body == player1_speech_bubble:
			DialogManager.start_dialog(player1_speech_bubble.position,lines_for_fail)
		else:
			DialogManager.start_dialog(player2_speech_bubble.position,lines_for_fail)
	for coin in coin_collection:
		coin.visible = true
		coin.set_collision_mask_value(2, 3)
		coin.get_node("AnimatedSprite2D").play("idle")
	is_in_order = false
	coin_index = 0
	fail_sound.play()
