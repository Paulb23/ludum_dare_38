extends Sprite

export var health = 10
var dead = false
var speed = 25

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if dead and not get_node("AnimationPlayer").is_playing():
		queue_free()
	if not dead:
		var direction = Vector2(400, 300) - get_pos()
		direction = direction.normalized( )
		direction.x = direction.x * speed * delta
		direction.y = direction.y * speed * delta
		set_pos(get_pos() + direction)

func hit(dmg):
	health -= dmg
	if health <= 0 and not dead:
		get_node("Area2D/CollisionShape2D").set_trigger(true)
		dead = true
		get_node("AnimationPlayer").play("explode");
		get_node("SamplePlayer").play("explosion_" + str(round(rand_range(0, 3))))
		get_parent().enemy_killed()