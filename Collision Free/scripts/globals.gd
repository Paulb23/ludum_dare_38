extends Node2D

const screenWidth = 800
const screenHeight = 600

var currentScene = null


func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	set_screen_res(screenWidth, screenHeight)
	set_globals()

func set_scene(newScenePath):
	currentScene.queue_free()
	currentScene.set_name( currentScene.get_name() + "_deleted" )
	var newScene = ResourceLoader.load(newScenePath)
	currentScene = newScene.instance()
	get_tree().get_root().add_child(currentScene)

func set_screen_res(width, height):
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(width , height))

func set_globals():
	Globals.set("SCREEN_WIDTH", screenWidth)
	Globals.set("SCREEN_HEIGHT", screenHeight)
	Globals.set("CURRENT_WAVE", 0)
	Globals.set("FIRST_TIME", 1)