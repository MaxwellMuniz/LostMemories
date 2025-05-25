extends State

var can_transition: bool = false

func enter():
	super.enter()

	if animation_player != null:
		animation_player.play("Teleport")
		await animation_player.animation_finished

	can_transition = true
	teleport()

func teleport():
	if player == null:
		push_error("❌ player è null in teleport()")
		return

	if owner == null:
		push_error("❌ owner è null")
		return

	owner.position = player.position + Vector2.RIGHT * 40

func transition():
	if can_transition:
		get_parent().change_state("Attack")
		can_transition = false
