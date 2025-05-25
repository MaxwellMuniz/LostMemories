extends CharacterBody2D

# Tecla de ataque (ex: "z" ou "x"), configurável no editor
@export var attack_key := ""

# Caminho até o HUD de HP do oponente (ex: /root/Chapter_3/CanvasLayer/Control/HP2)
@export var opponent_hp_path: NodePath

# Controle de cooldown para evitar ataques seguidos muito rápidos
var can_attack := true

func _process(delta):
	# Verifica se o jogador apertou a tecla de ataque
	if Input.is_action_just_pressed(attack_key):
		attack()

func attack():
	# Verifica se o ataque pode ser realizado (cooldown ativo)
	if not can_attack:
		return

	# Verifica todos os corpos dentro da área de ataque (Area2D)
	for body in $AttackHitbox.get_overlapping_bodies():
		# Checa se o corpo é o outro jogador
		if body.name == "Player" or body.name == "Player2":
			# Evita múltiplos ataques durante o cooldown
			can_attack = false
			
			# Acessa o HUD de HP do oponente e reduz em 1
			var hp_node = get_node(opponent_hp_path)
			hp_node.set_hp(hp_node.hp - 1)

			# Aguarda 1 segundo para permitir o próximo ataque
			await get_tree().create_timer(1.0).timeout
			can_attack = true

func get_direction_as_string():
	var dir = $RayCast2D.target_position
	if dir.x > 0:
		return "right"
	elif dir.x < 0:
		return "left"
	elif dir.y > 0:
		return "down"
	elif dir.y < 0:
		return "up"
