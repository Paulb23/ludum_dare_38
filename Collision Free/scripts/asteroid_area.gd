extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func hit(dmg):
	get_parent().hit(dmg)
