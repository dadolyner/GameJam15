extends Node2D

@export var coin_collection: Array[Area2D]

@onready var pickup_sound: AudioStreamPlayer = $PickupSound
@onready var fail_sound: AudioStreamPlayer = $FailSound

var is_in_order: bool = false
var coin_index: int = 0

func pickup_coin(coin: Area2D) -> void:
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
			reset_coins()

func reset_coins() -> void:
	for coin in coin_collection:
		coin.visible = true
		coin.set_collision_mask_value(2, 3)
		coin.get_node("AnimatedSprite2D").play("idle")
	is_in_order = false
	coin_index = 0
	fail_sound.play()
