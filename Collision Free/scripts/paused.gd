extends Sprite

var speed = 400
var slide_on = false
var slide_off = false
var start_pos

func _ready():
	start_pos = get_pos()
	set_fixed_process(true)
	set_process_input(true)
	get_node("backing/music_vol").connect("value_changed", self, "music_vol")
	get_node("backing/fx_vol").connect("value_changed", self, "sfx_vol")

	get_node("backing/menu").connect("pressed", self, "menu_pressed")
	get_node("backing/restart").connect("pressed", self, "restart_pressed")
	get_node("backing/continue").connect("pressed", self, "continue_pressed")
	get_node("backing/exit").connect("pressed", self, "exit_pressed")

func _fixed_process(delta):
	if slide_on:
		var direction = Vector2(400, 100) - get_pos()
		direction = direction.normalized( )
		direction.x = direction.x * speed * delta
		direction.y = direction.y * speed * delta
		set_pos(get_pos() + direction)
		if (get_pos().distance_to(Vector2(400, 100))) < 5:
			get_parent().get_node("SamplePlayer").stop_all()
			slide_on = false

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
			get_tree().set_pause(false)

func _input(event):
	if event.is_action("pause") && !event.is_echo() && event.is_action_released("pause") and not slide_off and not slide_on and get_parent().get_node("planet").health > 0:
		if get_tree().is_paused():
			slide_off();
		else:
			show();
			get_tree().set_pause(true);
			get_node("backing/music_vol").set_value(AudioServer.get_stream_global_volume_scale());
			get_node("backing/fx_vol").set_value(AudioServer.get_fx_global_volume_scale())

func show():
	set_fixed_process(true)
	slide_on = true

func slide_off():
	slide_off = true

func music_vol(val):
	AudioServer.set_stream_global_volume_scale(val)
	pass

func sfx_vol(val):
	AudioServer.set_fx_global_volume_scale(val)
	pass

func menu_pressed():
	get_tree().set_pause(false);
	globals.set_scene("res://scenes/main_menu.tscn");

func restart_pressed():
	get_tree().set_pause(false);
	globals.set_scene("res://scenes/game.tscn");

func continue_pressed():
	slide_off();

func exit_pressed():
	get_tree().quit()