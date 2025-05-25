extends Node2D
class_name State

@onready var debug = owner.find_child("debug")
@onready var animation_player = owner.find_child("AnimationPlayer")

var player: Node2D = null

func _ready():
	set_physics_process(false)
	
	# Trova il primo nodo nel gruppo "Players"
	var players = get_tree().get_nodes_in_group("Players")
	if players.size() > 0:
		player = players[0] as Node2D
	else:
		push_error("❌ Nessun nodo nel gruppo 'Players' trovato!")

func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func transition():
	pass

func _physics_process(_delta):
	transition()
	if debug:
		debug.text = name
