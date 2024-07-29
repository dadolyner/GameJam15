extends CanvasLayer

@onready var label: Label = $Label

func _ready() -> void:
	GameTimer.start_timer()
	var points = int(GameManager.get_points())
	GameManager.set_current_level_points(points)

func _process(_delta) -> void:
	label.text = GameManager.get_points()
