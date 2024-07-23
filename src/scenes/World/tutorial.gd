extends Node2D

@onready var player_1 = $Player_1
@onready var player_2 = $Player_2
@onready var area_2d_p_1 = $Area2D_p1
@onready var area_2d_p_2 = $Area2D_p2

@onready var kiwi = $Kiwi
@onready var kiwi_2 = $Kiwi2
@onready var kiwi_3 = $Kiwi3
@onready var kiwi_4 = $Kiwi4

func _on_area_2d_p_1_body_entered(body):
	Signals.triggers_tutorial_p1.emit(body)
	area_2d_p_1.set_collision_mask_value(2, 0)

func _on_area_2d_p_2_body_entered(body):
	Signals.triggers_tutorial_p2.emit(body) 
	area_2d_p_2.set_collision_mask_value(2, 0)

func _on_kiwi_body_entered(body):
	Signals.triggers_tutorial_kiwi.emit(body)
	GameManager.add_points(5)
	kiwi.set_collision_mask_value(2, 0)
	kiwi.visible = false

func _on_kiwi_2_body_entered(body):
	Signals.triggers_tutorial_kiwi.emit(body)
	GameManager.add_points(5)
	kiwi_2.set_collision_mask_value(2, 0)
	kiwi_2.visible = false

func _on_kiwi_3_body_entered(body):
	Signals.triggers_tutorial_kiwi.emit(body)
	GameManager.add_points(5)
	kiwi_3.set_collision_mask_value(2, 0)
	kiwi_3.visible = false

func _on_kiwi_4_body_entered(body):
	Signals.triggers_tutorial_kiwi.emit(body)
	GameManager.add_points(5)
	kiwi_4.set_collision_mask_value(2, 0)
	kiwi_4.visible = false

func _on_area_2d_body_entered(body):
	GameManager.reset_points()
