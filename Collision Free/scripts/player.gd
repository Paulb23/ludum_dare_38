extends KinematicBody2D

var angle = 86.45;

var planet_center_x = 400
var planet_center_y = 300
var radius = 100
var speed = 3

var dmg = 10
var dmgScale = 1
var bullet = null
var can_shoot = true
var shoot_timer
var animation
var start_pos

var starting = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)

	animation = get_node("AnimationPlayer")

	shoot_timer = get_node("shoot_timer");
	shoot_timer.connect("timeout", self, "shoot_timer")
	bullet = load("res://scenes/bullet.tscn")

	start_pos = get_pos()
	set_pos(Vector2(start_pos.x, -50))
	starting = true

func _fixed_process(delta):
	if not starting:
		handle_movment(delta)
		handle_shot()

	if starting:
		var direction = start_pos - get_pos()
		direction = direction.normalized( )
		direction.x = direction.x * 100 * delta
		direction.y = direction.y * 100 * delta
		set_pos(get_pos() + direction)

		if start_pos.distance_to(get_pos()) < 1:
			starting = false;

func _input(event):
	pass

func handle_movment(delta):
	if Input.is_action_pressed("move_left"):
		angle -= speed * delta
		self.look_at(Vector2(planet_center_x, planet_center_y))
		self.move_to(Vector2(planet_center_x+cos(angle)*radius, planet_center_y+sin(angle)*radius))
	elif Input.is_action_pressed("move_right"):
		angle += speed * delta
		self.look_at(Vector2(planet_center_x, planet_center_y))
		self.move_to(Vector2(planet_center_x+cos(angle)*radius, planet_center_y+sin(angle)*radius))

func handle_shot():
	if Input.is_action_pressed("fire") and can_shoot:
		fire(Vector2(get_pos().x, get_pos().y), angle, 200)
		can_shoot = false
		animation.play("shoot")
		get_node("SamplePlayer").play("shoot_" + str(round(rand_range(0, 3))))
		shoot_timer.start()
	if not animation.is_playing():
		animation.play("idle")

func fire(start_pos, target_pos, bullet_speed):
	var node = bullet.instance()
	node.parent = "player"
	node.dmg = dmg * dmgScale
	node.set_pos(start_pos)
	node.set_speed(bullet_speed)
	node.set_taget(angle)
	get_parent().add_child(node)

func shoot_timer():
	can_shoot = true
