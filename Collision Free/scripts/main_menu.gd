extends Node2D

func _ready():
	get_node("play").connect("pressed", self, "menu_pressed")
	get_node("exit").connect("pressed", self, "exit_pressed")

func menu_pressed():
	globals.set_scene("res://scenes/game.tscn");

func exit_pressed():
	get_tree().quit()
