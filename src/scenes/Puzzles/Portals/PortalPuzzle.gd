extends Node2D

@onready var pickup_sound: AudioStreamPlayer = $Pickup_sound
@onready var lever: Area2D = $TogglePortal/Lever

@export var cherry_collection: Array[Area2D]

var number_of_cherries: int = 0
var collected_cherries: int = 0

func _ready() ->void:
	lever.visible = false
	lever.set_collision_mask_value(2, 0)
	number_of_cherries = len(cherry_collection)

func _process(_delta) ->void:
	if collected_cherries == number_of_cherries:
		lever.visible = true
		lever.set_collision_mask_value(2, 1)

func pickup_cherry(cherry: Area2D) ->void:
	collected_cherries += 1
	pickup_sound.play()
	cherry.queue_free()
