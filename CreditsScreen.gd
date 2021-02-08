extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false

func start():
	enabled = true
	self.visible = true
	return

func stop():
	enabled = false
	self.visible = false
	return
	
func _process(delta):
	if enabled == false:
		return
	if Input.get_action_strength("ui_cancel"):
		get_parent().changeGameState("StartScreen")
		
