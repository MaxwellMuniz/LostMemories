extends Node2D

@onready var hp1 = $CanvasLayer/Control/HP1
@onready var hp2 = $CanvasLayer/Control/HP2

var player1_dead = false
var player2_dead = false

func _ready():
	# Conecta os sinais de gameover
	hp1.connect("gameover", Callable(self, "_on_player1_gameover"))
	hp2.connect("gameover", Callable(self, "_on_player2_gameover"))

func _on_player1_gameover():
	player1_dead = true
	check_both_dead()

func _on_player2_gameover():
	player2_dead = true
	check_both_dead()

func check_both_dead():
	if player1_dead and player2_dead:
		end_game("Empate!")
	elif player1_dead:
		end_game("Player 2 venceu!")
	elif player2_dead:
		end_game("Player 1 venceu!")

func end_game(message: String):
	print(message)
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
