extends Path2D

@onready var path: PathFollow2D = $PathFollow2D

@export var speed: float = 1.0

func _process(_delta) -> void:  
	path.progress += speed
