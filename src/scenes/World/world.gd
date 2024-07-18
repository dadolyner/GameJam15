extends Node2D

@onready var moon_teleport = $MoonTeleport
@onready var sun_teleport = $SunTeleport

# Called when the node enters the scene tree for the first time.
func _ready():
	moon_teleport.play("idle")
	sun_teleport.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
