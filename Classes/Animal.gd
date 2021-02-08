extends "OBJECT_SOLID.gd"
var imageNames = ["CubicAraraAzul.png", "CubicBat.png", "CubicBull.png", "CubicBunny.png", "CubicCat.png", 
"CubicChameleon.png", "CubicChicken.png", "CubicCow.png", "CubicDolphin.png", "CubicDolphin.png", "CubicDuck.png",
"CubicElephant.png", "CubicFish.png", "CubicFlamingo.png", "CubicFox.png", "CubicFrog.png", "CubicGiraffe.png",
"CubicGrizzly.png", "CubicHorse.png", "CubicJaguatirica.png", "CubicLion.png", "CubicLoboGuara.png", "CubicMicoLeaoDourado.png",
"CubicMonkey.png", "CubicMoose.png", "CubicOwl.png", "CubicPanda.png", "CubicPenguin.png", "CubicPig.png", 
"CubicPolar.png", "CubicRaccoon.png", "CubicRat.png", "CubicRhino.png", "CubicSheep.png", "CubicShiba.png", 
"CubicSnake.png", "CubicToucan.png", "CubicTurtle.png", "CubicUnicorn.png", "CubicWolf.png", "CubicZebra.png"]

onready var Grid = get_parent()

var rng = RandomNumberGenerator.new()
var animalName = ""
func _ready():
	rng.randomize()
	var num = rng.randi_range(0, imageNames.size()-1)
	animalName = "res://Sprites/Animals/"+imageNames[num]
	$Sprite.texture = load(animalName)


func getAnimalName():
	return animalName

func bump():
	$AnimationPlayer.play("Bump")
	$AudioStreamPlayer.play()
	return

func _process(delta):
	var move_direction
	match rng.randi_range(0,3):
		0:
			move_direction = Vector2.UP
		1: 
			move_direction = Vector2.DOWN
		2:
			move_direction = Vector2.LEFT
		3:
			move_direction = Vector2.RIGHT
			
	var target_position = Grid.request_move(self, move_direction)
	if not target_position:
		return
	
	$AnimationPlayer.play("Default")
	set_process(false)
	$Tween.interpolate_property(self, "position",position, target_position, $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
	return
	


