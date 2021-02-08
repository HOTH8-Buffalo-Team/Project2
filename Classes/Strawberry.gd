extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var doConsume = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func onTrigger(pawn):
	if pawn.addItem("res://Sprites/Objects/Strawberry.png"):
		doConsume = true
	
func consume():
	return doConsume

func onCollide():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
