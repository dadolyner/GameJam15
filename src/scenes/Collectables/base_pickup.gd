extends Node2D

@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound

func pickup_item(item: Area2D, body: Node) -> void:
	pickup_sound.play()
	GameManager.add_points(20)
	item.set_collision_mask_value(2, 0)
	item.visible = false
