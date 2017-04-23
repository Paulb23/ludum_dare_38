extends Sprite

export var health = 10
var dead = false
var speed = 25
var spin_dir

func _ready():
	spin_dir = round(rand_range(0,1))
	set_fixed_process(true)
	get_node("Area2D").connect("body_enter", self, "collision")
	get_node("Area2D").connect("area_enter", self, "area_collision")
	speed = rand_range(15,25)
	var scale = round(rand_range(3,6))
	set_scale(Vector2(scale,scale))

func area_collision(body):
	collision(body)

func collision(body):
	if (body.get_parent().has_method("hit")):
		get_parent().shake(5,5);
		body.get_parent().hit(10)
		hit(health)

func _fixed_process(delta):
	if dead and not get_node("AnimationPlayer").is_playing():
		queue_free()
	if not dead:
		var direction = Vector2(400, 300) - get_pos()
		direction = direction.normalized( )
		direction.x = direction.x * speed * delta
		direction.y = direction.y * speed * delta
		set_pos(get_pos() + direction)
		if spin_dir:
			set_rot(get_rot()+0.01)
		else:
			set_rot(get_rot()-0.01)

func hit(dmg):
	health -= dmg
	if health <= 0 and not dead:
		get_node("Area2D/CollisionShape2D").set_trigger(true)
		dead = true
		get_node("AnimationPlayer").play("explode");
		get_node("SamplePlayer").play("explosion_" + str(round(rand_range(0, 3))))
		get_parent().enemy_killed()