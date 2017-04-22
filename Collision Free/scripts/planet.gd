extends Node2D

var health = 50

func _fixed_process(delta):
	if not get_node("AnimationPlayer").is_playing():
		get_tree().set_pause(false)
		globals.set_scene("res://scenes/game_over.tscn")

func hit(dmg):
	health -= dmg
	if health <= 0:
		set_pause_mode(PAUSE_MODE_PROCESS)
		get_node("AnimationPlayer").set_pause_mode(PAUSE_MODE_PROCESS)
		get_tree().set_pause(true)
		get_parent().get_node("loop_1").stop()
		get_node("AnimationPlayer").play("death")
		Globals.set("CURRENT_WAVE", get_parent().current_wave)
		set_fixed_process(true)
		pass