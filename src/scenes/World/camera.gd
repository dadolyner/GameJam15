extends Camera2D

@onready var tilemap: TileMap = $"../TileMap"
@onready var screen_size: Vector2 = get_viewport_rect().size
@onready var player_1: CharacterBody2D = $"../Players/Player_1"
@onready var player_2: CharacterBody2D = $"../Players/Player_2"

@onready var right_boundry: StaticBody2D = $RightBoundry
@onready var left_boundry: StaticBody2D = $LeftBoundry

@export var players: Array[CharacterBody2D]
@export var camera_speed: float = 5.0

var rng = RandomNumberGenerator.new()
var random_strength: float = 10.0
var shake_strength: float = 0.0
var shake_fade: float = 30.0

func _ready() -> void:
	add_camera_target(player_1)
	add_camera_target(player_2)
	set_camera_limits()
	set_camera_bounds()
	
func _process(delta: float) -> void:
	update_camera_position(delta)
	offset_camera_right()
	
	if Input.is_action_just_pressed("p1_shift") or Input.is_action_just_pressed("p2_shift"):
		shake_camera()
		
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = random_offset()

func add_camera_target(player) -> void:
	if not player in players:
		players.append(player)
		
func remove_camera_target(player) -> void:
	if player in players:
		players.erase(player)
	
func set_camera_limits() -> void:
	var tile_size: Vector2 = tilemap.get_tileset().tile_size
	var map_bounds: Rect2i = tilemap.get_used_rect()

	var top_left: Vector2 = tilemap.map_to_local(map_bounds.position)
	var bottom_right: Vector2 = tilemap.map_to_local(map_bounds.position + map_bounds.size)
	
	limit_right = int(bottom_right.x + (tile_size.x * 4.0))
	limit_left = int(top_left.x - (tile_size.x * 4.0))
	limit_top = 0
	limit_bottom = int(bottom_right.y - top_left.y)

func update_camera_position(delta: float) -> void:
	if players.size() < 2:
		return
	
	var player_1_pos: Vector2 = players[0].global_position
	var player_2_pos: Vector2 = players[1].global_position
	var midpoint: Vector2 = (player_1_pos + player_2_pos) / 2

	var tilemap_rect: Rect2i = tilemap.get_used_rect()
	var tilemap_bottom_right: Vector2 = tilemap.map_to_local(tilemap_rect.position + tilemap_rect.size)
	var tilemap_center: float = float(tilemap_bottom_right.y) / 2
	
	var target_position: Vector2 = Vector2(
		round(clamp(midpoint.x, limit_left + float(tilemap_rect.position.x) / 2, limit_right - float(tilemap_rect.position.x) / 2)),
		round(tilemap_center)
	)
	
	position = position.lerp(target_position, camera_speed * delta)

func set_camera_bounds() -> void:
	var viewport_size: Vector2 = get_viewport().size
	var half_screen_width: float = (viewport_size.x / 2) / zoom.x
	
	left_boundry.position.x = position.x - half_screen_width
	right_boundry.position.x = position.x + half_screen_width

func offset_camera_right() -> void:
	var half_screen_width: float = (screen_size.x / 2) / zoom.x
	var left_limit_reached: bool = position.x - half_screen_width <= limit_left
	if left_limit_reached:
		position.x = limit_left + half_screen_width + 1

func shake_camera() -> void:
	shake_strength = random_strength

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
