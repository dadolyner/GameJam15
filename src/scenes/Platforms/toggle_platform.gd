extends Path2D

@onready var path: PathFollow2D = $PathFollow2D
@onready var lever: Area2D = $"../Lever"

@export var speed: float = 1.0

func _process(_delta) -> void:
	if lever.get_lever_state() == 1:
		path.progress += speed
