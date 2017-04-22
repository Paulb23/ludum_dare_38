extends KinematicBody2D

var angle = 90;

var planet_center_x = 400
var planet_center_y = 300
var radius = 100
var speed = 2

func _ready():
	set_fixed_process(true)
	set_process_input(true)

	angle -= 180
	self.look_at(Vector2(planet_center_x, planet_center_y))
	self.move_to(Vector2(planet_center_x+cos(angle)*radius, planet_center_y+sin(angle)*radius))

func _fixed_process(delta):
	handle_movment(delta)

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
