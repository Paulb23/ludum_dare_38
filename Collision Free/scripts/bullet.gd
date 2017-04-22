extends Sprite

var speed
var angle = null
var dist = 100
var parent = null
var dmg = 0
var dead = 0

func get_health():
	return !dead

func set_speed(speed):
	self.speed = speed

func set_taget(target_angle):
	angle = target_angle

func area_collision(body):
	collision(body)

func collision(body):
	if (body.get_name() == "player" && parent == "player"):
		return
	if (body.has_method("hit")):
		get_parent().shake(5,5);
		body.hit(dmg)
		queue_free()


func _fixed_process(delta):
	if (dead == 0):
		dist += speed * delta
		var a = Vector2(400+cos(angle)*dist, 300+sin(angle)*dist)
		set_pos(a)
		look_at(Vector2(400, 300))

		if (get_pos().x > 820 || get_pos().x < -4):
			queue_free()

func _ready():
	get_node("Area2D").connect("body_enter", self, "collision")
	get_node("Area2D").connect("area_enter", self, "area_collision")
	set_fixed_process(true)