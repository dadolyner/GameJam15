extends Node2D

@onready var score_label: Label = $"../CanvasLayer/ScoreLabel"
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound

var tutorial_score: int

func add_point() -> void:
	tutorial_score += 5
	pickup_sound.play()
	score_label.text = str(tutorial_score)
