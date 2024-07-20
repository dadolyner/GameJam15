extends Area2D


@onready var pineapple_sprite = $pineapple_sprite
@onready var timetravel_puzzle = $".."
@onready var tt_pineapple = $"."
@export var player1: CharacterBody2D
@export var player2: CharacterBody2D

func _ready():
	pineapple_sprite.play("idle")


func _on_body_entered(body):
	timetravel_puzzle.start_timetravel(player1, player2, tt_pineapple)

