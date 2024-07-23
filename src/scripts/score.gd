extends CanvasLayer

@onready var label: Label = $Label

func _process(_delta) -> void:
	label.text = GameManager.get_points()
