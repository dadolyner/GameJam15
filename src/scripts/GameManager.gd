extends Node

var score: int = 0
var current_speaker: CharacterBody2D
var what_is_being_said: Array[String]

const lines_for_coin_tip: Array[String] = [
	"Maybe I should collect them in the correct order..."
]

func _ready():
	Signals.triggers_chat_coin_puzzle.connect(_coin_puzzle_fail)

func _process(_delta):
	if current_speaker != null:
		DialogManager.update_position(current_speaker.position)

func _coin_puzzle_fail(character):
	DialogManager.start_dialog(character.position, lines_for_coin_tip)
	current_speaker = character

func add_points(added_score) -> void:
	score = score + added_score
	
func get_points() -> String:
	return str(score)

func get_speaker() -> CharacterBody2D:
	return current_speaker

func set_speaker(speaker: CharacterBody2D) -> void:
	current_speaker = speaker
