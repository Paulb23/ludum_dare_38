extends Sprite

export var health = 10
var dead = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if dead and not get_node("AnimationPlayer").is_playing():
		queue_free()

func hit(dmg):
	health -= dmg
	if health <= 0:
		get_node("Area2D/CollisionShape2D").set_trigger(true)
		dead = true
		get_node("AnimationPlayer").play("explode");
		get_node("SamplePlayer").play("explosion_" + str(round(rand_range(0, 3))))