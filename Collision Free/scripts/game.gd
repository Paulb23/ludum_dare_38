extends Node2D

func _ready():
	pass

func shake(time, amount):
	get_node("Camera2D").shake(time, amount)
