extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Grid = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func onTrigger(pawn):
	if pawn.getItem() == "res://Sprites/Objects/Strawberry.png":
		pawn.bump()
		return
	if pawn.getItem() == null:
		return
	pawn.removeItem()
	Grid.removeAnimal()
	yield(get_tree().create_timer(0.1), "timeout")
	return

func consume():
	return false

func onCollide():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
