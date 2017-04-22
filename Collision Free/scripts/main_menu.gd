extends Node2D

func _ready():
	get_node("play").connect("pressed", self, "menu_pressed")
	get_node("exit").connect("pressed", self, "exit_pressed")
	get_node("music_vol").connect("value_changed", self, "music_vol")
	get_node("fx_vol").connect("value_changed", self, "sfx_vol")
	if Globals.get("FIRST_TIME"):
		Globals.set("FIRST_TIME", 0)
		music_vol(3)
		sfx_vol(5)
	get_node("music_vol").set_value(AudioServer.get_stream_global_volume_scale());
	get_node("fx_vol").set_value(AudioServer.get_fx_global_volume_scale())

func menu_pressed():
	globals.set_scene("res://scenes/game.tscn");

func exit_pressed():
	get_tree().quit()


func music_vol(val):
	AudioServer.set_stream_global_volume_scale(val)
	pass

func sfx_vol(val):
	AudioServer.set_fx_global_volume_scale(val)
	pass