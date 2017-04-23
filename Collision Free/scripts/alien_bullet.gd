extends Sprite

var speed
var target_pos = null
var dist = 100
var parent = null
var dmg = 0
var dead = 0

func get_health():
	return !dead

func set_speed(speed):
	self.speed = speed

func set_taget(target):
	target_pos = target

func area_collision(body):
	collision(body)

func collision(body):
	if (body.get_name() == "alien" && parent == "alien"):
		return
	if (body.get_parent().has_method("hit")):
		get_parent().shake(5,5);
		body.get_parent().hit(10)
		get_node("AnimationPlayer").play("death")
		queue_free()


func _fixed_process(delta):
	if (dead == 0):
		var direction = target_pos - get_pos()
		direction = direction.normalized( )
		direction.x = direction.x * speed * delta
		direction.y = direction.y * speed * delta
		set_pos(get_pos() + direction)
		look_at(Vector2(400, 300));
		set_rot(get_rot()-3.14159)

		if (get_pos().x > 820 || get_pos().x < -4):
			queue_free()
	if dead and not get_node("AnimationPlayer").is_playing():
		queue_free()

func hit(dmg):
	if not dead:
		dead = true
		get_node("AnimationPlayer").play("death")

func _ready():
	get_node("Area2D").connect("body_enter", self, "collision")
	get_node("Area2D").connect("area_enter", self, "area_collision")
	set_fixed_process(true)