extends Path2D

@onready var path: PathFollow2D = $PathFollow2D

@export var speed: float = 100.0

func _process(delta) -> void:  
	path.progress += speed * delta
