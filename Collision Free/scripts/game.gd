extends Node2D

var nodes = [
	load("res://scenes/asteroid_1.tscn")
]

var objects = 10
var current_wave = 1
var enemies_to_spawn = 0
var enemies_spawned = 0
var enemies_killed = 0
var in_wave = false
var spawn_timer

func _ready():
	spawn_timer = get_node("spawn_timer")
	set_fixed_process(true)
	get_node("between_round").connect("timeout", self, "start_next_wave")
	get_node("between_round").start()
	get_node("wave_back").show(current_wave)

func start_next_wave():
	if not in_wave:
		current_wave = current_wave + 1
		in_wave = true
		enemies_to_spawn = (objects*current_wave)-objects/2
		enemies_spawned = (objects*current_wave)-objects/2
		enemies_killed = 0
		spawn_enemy();

func spawn_enemy():
	if in_wave:
		print("spawning: " + str(enemies_to_spawn))
		enemies_to_spawn -= 1
		var node = nodes[0].instance()
		var side = round(rand_range(0,3))
		if side == 0:
			node.set_pos(Vector2(rand_range(-50, -100),rand_range(0, 600)))
		if side == 1:
			node.set_pos(Vector2(rand_range(850, 900),rand_range(0, 600)))
		if side == 2:
			node.set_pos(Vector2(rand_range(0, 800),rand_range(-50, -100)))
		if side == 3:
			node.set_pos(Vector2(rand_range(0, 800),rand_range(650, 700)))
		add_child(node)

		# random spawn times
		spawn_timer.set_one_shot(true)
		spawn_timer.set_wait_time(rand_range(0, 3))
		spawn_timer.start()
		yield(spawn_timer, "timeout")

		#keep spawing till we run out
		if (enemies_to_spawn > 0 ):
			spawn_enemy()

func _fixed_process(delta):
	if enemies_killed == enemies_spawned and in_wave:
		print("next_wave!")
		in_wave = false
		get_node("wave_back").show(current_wave)
		get_node("between_round").start()

func enemy_killed():
	enemies_killed += 1

func shake(time, amount):
	get_node("Camera2D").shake(time, amount)

