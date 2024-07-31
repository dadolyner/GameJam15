extends Area2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D
@export var potion: Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_2d = $"."


func _ready():
	animated_sprite_2d.play("idle")
	potion.visible = true
	animated_sprite_2d.visible = true

func _on_body_entered(body):
	animated_sprite_2d.play("pickup")


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "pickup":
		animated_sprite_2d.visible = false
