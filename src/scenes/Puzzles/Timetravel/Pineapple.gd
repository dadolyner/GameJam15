extends Area2D

@onready var timetravel_puzzle = $".."
@onready var sprite_2d = $Sprite2D
@onready var pineapple = $"."

func _ready():
	sprite_2d.play("idle")

func _on_body_entered(_body):
	timetravel_puzzle.start_timetravel(pineapple)
