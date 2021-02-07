extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Game = get_parent()
var running = true
var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start():
	running = true
	$Particles.emitting = true

func stop():
	running = false
	$Particles.emitting = false


func checkInputs():
	var strength = 0
	strength += Input.get_action_strength("ui_accept")
	strength += Input.get_action_strength("ui_down")
	strength += Input.get_action_strength("ui_up")
	return (strength>0)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func selectCurrentItem():
	if selected == 0:
		Game.changeGameState("Play")
	if selected == 1:
		return
		

func _process(delta):
	if not checkInputs() or running == false:
		return
	
	var dir = Vector2(0,Input.get_action_strength("ui_down")) - Vector2(0,Input.get_action_strength("ui_up"))
	
	selected += dir.normalized().y
	
	print(selected)
	if selected < 0:
		selected = 0
	if selected > 1:
		selected = 1
	
	match selected:
		0:
			$Select1.color = Color(255,255,255,255)
			$Select2.color = Color(0,0,0,255)
			return
		1:
			$Select2.color = Color(255,255,255,255)
			$Select1.color = Color(0,0,0,255)
			return
	
	
	if Input.get_action_strength("ui_accept") > 0:
		selectCurrentItem()
		
