extends Node2D

var nodes = [
	load("res://scenes/asteroid_1.tscn")
]

var current_wave = 1
var enemies_to_spawn = 0
var enemies_spawned = 0
var enemies_killed = 0
var in_wave = false
var spawn_timer
var hit_timer

func _ready():
	spawn_timer = get_node("spawn_timer")
	hit_timer = get_node("hit_timer")
	set_fixed_process(true)
	get_node("between_round").connect("timeout", self, "start_next_wave")
	get_node("between_round").start()
	get_node("wave_back").show(current_wave)

func start_next_wave():
	if not in_wave:
		current_wave = current_wave + 1
		in_wave = true
		enemies_to_spawn = 10 + (5 * current_wave)
		enemies_spawned = 10 + (5 * current_wave)
		enemies_killed = 0
		spawn_enemy();

func spawn_enemy():
	if in_wave:
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
		in_wave = false
		get_node("wave_back").show(current_wave)
		get_node("between_round").start()
		get_node("SamplePlayer").play("wave_end")

func enemy_killed():
	enemies_killed += 1
	if (get_node("planet").health > 0):
		self.set_pause_mode(PAUSE_MODE_PROCESS)
		hit_timer.set_pause_mode(PAUSE_MODE_PROCESS)
		get_tree().set_pause(true)
		hit_timer.set_one_shot(true)
		hit_timer.set_wait_time(0.07)
		hit_timer.start()
		yield(hit_timer, "timeout")
		get_tree().set_pause(false)
		self.set_pause_mode(PAUSE_MODE_INHERIT)
		hit_timer.set_pause_mode(PAUSE_MODE_INHERIT)

func shake(time, amount):
	get_node("Camera2D").shake(time, amount)

