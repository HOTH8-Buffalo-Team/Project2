extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var doConsume = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func onCollide():
	pass

func consume():
	return doConsume

func onTrigger(player):
	if player.getItem() != "res://Sprites/Objects/Strawberry.png":
		get_parent().bump()
		return
	player.removeItem()
	player.addItem(get_parent().getAnimalName())
	doConsume = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
