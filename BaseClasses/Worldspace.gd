extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start():
	running = true
	$Grid/Player.set_active(true)
	
	
func stop():
	running = false
	$Grid/Player.set_active(false)
	
func isRunning():
	return running
	

func _process(delta):
	if running == false:
		return
		
