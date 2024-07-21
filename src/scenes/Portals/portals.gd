extends Node2D
enum PlayerModel { MOON, SUN }

@export var portal_model: PlayerModel
@export var portal_active: bool = true
@export var player: CharacterBody2D
@export var player_controls: PlayerControls
