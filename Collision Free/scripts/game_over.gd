extends Node2D

func _ready():
	get_node("score").set_text("You Lasted " + str(Globals.get("CURRENT_WAVE") - 1) + " Waves")
	get_node("menu").connect("pressed", self, "menu_pressed")
	get_node("retry").connect("pressed", self, "retry_pressed")
	get_node("exit").connect("pressed", self, "exit_pressed")

func menu_pressed():
	pass

func retry_pressed():
	globals.set_scene("res://scenes/game.tscn");

func exit_pressed():
	get_tree().quit()
