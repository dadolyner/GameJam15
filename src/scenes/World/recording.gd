extends Area2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D
@export var potion: Area2D
@onready var animated_sprite_2d = $"../Area2D2/AnimatedSprite2D"
@onready var area_2d_2 = $"../Area2D2"

func _on_body_entered(body):
	if body == player1:
		player1.modulate = Color(0.539, 0.738, 0.65)
		await get_tree().create_timer(2).timeout 
		player1.modulate = Color(0.47, 0.763, 0.571)	
		await get_tree().create_timer(2).timeout
		player1.modulate = Color(0.382, 0.784, 0.511)	


func _on_area_2d_2_body_entered(body):
	area_2d_2.rotation = -45 
