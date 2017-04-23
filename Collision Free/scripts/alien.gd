extends Sprite

export var health = 20
var dead = false
var speed = 25

var dmg = 10
var dmgScale = 1
var bullet = null
var can_shoot = true
var shoot_timer

func _ready():
	shoot_timer = get_node("shoot_timer");
	shoot_timer.connect("timeout", self, "shoot_timer")
	shoot_timer.set_one_shot(true)
	shoot_timer.set_wait_time(rand_range(5, 10))
	shoot_timer.start()
	bullet = load("res://scenes/alien_bullet.tscn")

	set_fixed_process(true)

func _fixed_process(delta):
	if dead and not get_node("AnimationPlayer").is_playing():
		queue_free()
	if not dead:
		if get_pos().distance_to(Vector2(400, 300)) > 300:
			var direction = Vector2(400, 300) - get_pos()
			direction = direction.normalized( )
			direction.x = direction.x * speed * delta
			direction.y = direction.y * speed * delta
			set_pos(get_pos() + direction)
			look_at(Vector2(400, 300));
			set_rot(get_rot()-3.14159)
		if not get_node("AnimationPlayer").is_playing():
			set_frame(0)

func shoot_timer():
	if not dead:
		get_parent().shake(2,2);
		get_node("SamplePlayer").play("alien_shoot_" + str(round(rand_range(0, 3))))
		get_node("AnimationPlayer").play("shoot")
		fire(get_pos(), Vector2(400, 300), 35)
		shoot_timer.set_wait_time(rand_range(5, 10))
		shoot_timer.start()

func fire(start_pos, target_pos, bullet_speed):
	var node = bullet.instance()
	node.parent = "alien"
	node.dmg = dmg * dmgScale
	node.set_pos(start_pos)
	node.set_speed(bullet_speed)
	node.set_taget(target_pos)
	get_parent().add_child(node)

func hit(dmg):
	health -= dmg
	if health <= 0 and not dead:
		get_node("alien/CollisionShape2D").set_trigger(true)
		dead = true
		get_node("AnimationPlayer").play("death")
		get_node("SamplePlayer").play("explosion_" + str(round(rand_range(0, 3))))
		get_parent().enemy_killed()