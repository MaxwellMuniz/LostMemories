extends HBoxContainer

signal gameover

var hp := 3
const MAX_HP := 3

func set_hp(value: int) -> void:
	hp = clamp(value, 0, MAX_HP)
	update_hearts()
	if hp == 0:
		emit_signal("gameover")

func update_hearts() -> void:
	for i in range(MAX_HP):
		var heart = get_node("Heart" + str(i + 1))
		heart.visible = hp > i
