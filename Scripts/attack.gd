extends State
 
func enter():
	super.enter()
	combo()
 
func Attack(move = "1"):
	animation_player.play("Attack_" + move)
	await animation_player.animation_finished
 
 
func combo():
	var move_set = ["1","1","2"]
	for i in move_set:
		await Attack(i)
 
	combo()
 
func transition():
	if owner.direction.length() > 40:
		get_parent().change_state("Follow")
