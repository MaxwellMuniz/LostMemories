extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var progress_bar = $UI/ProgressBar
@onready var fsm = find_child("FiniteStateMachine")

var player = null
var direction : Vector2

var health := 10:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			if fsm:
				fsm.change_state("Death")

func _ready():
	var players = get_tree().get_nodes_in_group("Players")
	print("Player trovati:", players)
	if players.size() > 0:
		player = players[0]
		print("✔️ Player assegnato:", player.name)
		set_physics_process(true)
	else:
		push_error("❌ Nessun player nel gruppo 'Players'")
		set_physics_process(false)

func _process(_delta):
	if player == null:
		return
	direction = player.position - position
	animated_sprite.flip_h = direction.x < 0

func _physics_process(delta):
	if player == null:
		return
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func take_damage():
	health -= 2
