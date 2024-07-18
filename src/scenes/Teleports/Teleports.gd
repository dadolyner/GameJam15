extends Area2D

@onready var player_1 = $"../../../Player_1"
@onready var player_2 = $"../../../Player_2"
@onready var sprite = $AnimatedSprite2D
@export var target_path: NodePath
@onready var target = get_node(target_path)
@export var TeleportModel: int = 0
var isMoonOverTeleport: bool = false
var isSunOverTeleport: bool = false

var player1Position
var player2Position

# Called when the node enters the scene tree for the first time.
func _ready():
	if(TeleportModel == 0):
		sprite.play("moon")
	if(TeleportModel == 1):
		sprite.play("sun")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isMoonOverTeleport and Input.is_action_just_pressed("p1_interact") and TeleportModel==0:
		player1Position.position = target.position	
	if isSunOverTeleport and Input.is_action_just_pressed("p2_interact") and TeleportModel==1:
		player2Position.position = target.position

func _on_body_entered(body):
	if(body == player_1):
		player1Position = body
		isMoonOverTeleport = true
	if(body == player_2):
		player2Position = body
		isSunOverTeleport = true
		

func _on_body_exited(body):
	if(body == player_1):
		player1Position = body
		isMoonOverTeleport = false
	if(body == player_2):
		player2Position = body
		isSunOverTeleport = false
