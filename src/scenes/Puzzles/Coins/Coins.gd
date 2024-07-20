extends Area2D

@onready var coin_puzzle = $".."
@onready var coins = $"."
@onready var sprite_2d = $Sprite2D
const COINS_ANIMATIONS = preload("res://assets/CoinsAnimations.tres")

func _ready():
	sprite_2d.play("idle")


func _on_body_entered(_body):
	coin_puzzle.pickup_coin(coins)


func _on_sprite_2d_animation_finished():
	if sprite_2d.animation == "explosion":
		coins.visible = false
