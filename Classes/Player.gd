extends "res://BaseClasses/Pawn.gd"

onready var Grid = get_parent()
onready var Workspace = Grid.get_parent()

var held:PoolStringArray = []
var maxHeld = 3
var direction = Vector2.DOWN
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	face_direction(Vector2.DOWN)
	if Workspace.isRunning() != true:
		set_active(false)
		
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var input_direction = get_input_direction()
	var isPressingSpace = Input.get_action_strength("ui_select")
	if not input_direction and isPressingSpace != 1:
		return
	
	if isPressingSpace == 1:
		Grid.attempt_trigger(self, direction)
		return
		
	face_direction(input_direction)

	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
		$Tween.start()
	else:
		bump()
		yield($AnimationPlayer, "animation_finished")
		face_direction(input_direction)
		
	
# Change the direction that the character is facing
func face_direction(new_direction):
	# Process Animations for each direction
	if new_direction.y == -1:
		$AnimationPlayer.play("IdleUp")
	if (new_direction.y == 1):
		$AnimationPlayer.play("IdleDown")
	if (new_direction == Vector2.LEFT):
		$AnimationPlayer.play("IdleLeft")
	if (new_direction == Vector2.RIGHT):
		$AnimationPlayer.play("IdleRight")
	direction = new_direction

# Get direction as a vector of two inputs
func get_input_direction():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

func move_to(target_position):
	
	if direction.y == -1:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("RunUp")
	if (direction.y == 1):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("RunDown")
	if (direction == Vector2.LEFT):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("RunLeft")
	if (direction == Vector2.RIGHT):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("RunRight")
		
	set_process(false)
	var move_direction = (position - target_position).normalized()
	
	$Tween.interpolate_property(self, "position",position, target_position, $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
	face_direction(direction)

func bump():
	$AnimationPlayer.play("Bump")
	
# Add an item to the character's inventory
func addItem(name:String):
	if held.size() >= maxHeld:
		return false
	
	held.append(name)
	
	if held.size() == 1:
		if name == "res://Sprites/Objects/Strawberry.png":
			$Pivot/Sprite/Animal1.hframes = 1
			$Pivot/Sprite/Animal1.frame_coords = Vector2()
		else :
			$Pivot/Sprite/Animal1.hframes = 4
			$Pivot/Sprite/Animal1.frame = 3
		$Pivot/Sprite/Animal1.visible = true
		$Pivot/Sprite/Animal1.texture = load(held[0])
	if held.size() == 2:
		if name == "res://Sprites/Objects/Strawberry.png":
			$Pivot/Sprite/Animal2.hframes = 1
			$Pivot/Sprite/Animal2.frame_coords = Vector2()
		else :
			$Pivot/Sprite/Animal2.hframes = 4
			$Pivot/Sprite/Animal2.frame = 3
		$Pivot/Sprite/Animal2.visible = true
		$Pivot/Sprite/Animal2.texture = load(held[1])
	if held.size() == 3:
		if name == "res://Sprites/Objects/Strawberry.png":
			$Pivot/Sprite/Animal3.hframes = 1
			$Pivot/Sprite/Animal3.frame_coords = Vector2()
		else :
			$Pivot/Sprite/Animal3.hframes = 4
			$Pivot/Sprite/Animal3.frame = 3
		$Pivot/Sprite/Animal3.visible = true
		$Pivot/Sprite/Animal3.texture = load(held[2])
	return true

# Remove an item from the character's inventory
func removeItem():
	if held.size() == 0:
		return false
	if held.size() == 1:
		$Pivot/Sprite/Animal1.visible = false
	if held.size() == 2:
		$Pivot/Sprite/Animal2.visible = false
	if held.size() == 3:
		$Pivot/Sprite/Animal3.visible = false
	held.remove(held.size()-1)
	return true

# Get item at position pos in character's inventory
func getItem():
	if held.size()<=0:
		return
	return held[held.size()-1]
