extends Panel

@onready var label_1: Label = $HBoxContainer/Label_1
@onready var label_2: Label = $HBoxContainer/Label_2
@onready var label_3: Label = $HBoxContainer/Label_3

func _process(_delta) -> void:
	var timer_props = GameTimer.get_timer_props()
	
	label_1.text = "%02d:" % timer_props.minutes
	label_2.text = "%02d." % timer_props.seconds
	label_3.text = "%03d" % timer_props.miliseconds
