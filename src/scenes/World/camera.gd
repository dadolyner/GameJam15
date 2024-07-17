extends Camera2D

@onready var tilemap: TileMap = $"../TileMap"
@onready var screen_size: Vector2 = get_viewport_rect().size
@onready var player_1: CharacterBody2D = $"../Player_1"
@onready var player_2: CharacterBody2D = $"../Player_2"

@export var players: Array[CharacterBody2D]
@export var margin = 50

func _ready():
	add_camera_target(player_1)
	add_camera_target(player_2)
	set_camera_limits()
	
func _process(_delta):
	update_camera_position()

func add_camera_target(player):
	if not player in players:
		players.append(player)
		
func remove_camera_target(player):
	if player in players:
		players.erase(player)
	
func set_camera_limits():
	var tile_size: Vector2 = tilemap.get_tileset().tile_size
	var map_bounds = tilemap.get_used_rect()

	var top_left = tilemap.map_to_local(map_bounds.position)
	var bottom_right = tilemap.map_to_local(map_bounds.position + map_bounds.size)
	
	limit_right = bottom_right.x + (tile_size.x * 4)
	limit_left = top_left.x - (tile_size.x * 4)

func update_camera_position():
	if players.size() < 2:
		return
	
	var player_1_pos = players[0].global_position
	var player_2_pos = players[1].global_position
	var midpoint = (player_1_pos + player_2_pos) / 2
	
	var tilemap_rect = tilemap.get_used_rect()
	var tilemap_bottom_right = tilemap.map_to_local(tilemap_rect.position + tilemap_rect.size)
	var tilemap_center = tilemap_bottom_right.y / 2
	
	position = Vector2(
		clamp(midpoint.x, limit_left + tilemap_rect.position.x / 2, limit_right - tilemap_rect.position.x / 2),
		tilemap_center
	)
