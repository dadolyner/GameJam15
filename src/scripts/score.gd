extends CanvasLayer

@onready var label = $Label

func _process(_delta):
	label.text = GameManager.get_points()
