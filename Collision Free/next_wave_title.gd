extends Sprite

var speed = 400
var slide_on = false
var slide_off = false
var wave
var start_pos

func _ready():
	start_pos = get_pos()
	set_fixed_process(true)
	get_node("wait").connect("timeout", self, "slide_off")

func _fixed_process(delta):
	if slide_on:
		var direction = Vector2(400, 100) - get_pos()
		direction = direction.normalized( )
		direction.x = direction.x * speed * delta
		direction.y = direction.y * speed * delta
		set_pos(get_pos() + direction)
		if (get_pos().distance_to(Vector2(400, 100))) < 5:
			slide_on = false
			get_node("wait").start()
			set_fixed_process(false)

	if slide_off:
		var direction = Vector2(1600, 100) - get_pos()
		direction = direction.normalized( )
		direction.x = direction.x * speed * delta
		direction.y = direction.y * speed * delta
		set_pos(get_pos() + direction)
		if (get_pos().distance_to(Vector2(1600, 100))) < 5:
			slide_off = false
			set_pos(start_pos);
			set_fixed_process(false)

func show(next_wave):
	set_fixed_process(true)
	get_node("Label").set_text("Wave " + str(next_wave))
	wave = next_wave
	slide_on = true

func slide_off():
	set_fixed_process(true)
	slide_off = true

