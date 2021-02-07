extends Node2D


var gameState = "StartScreen"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("FadeIn")
	changeGameState("StartScreen")
	

func changeGameState(state):
	gameState = state
	if gameState == "Play":
		$StartScreen.stop()
		$AnimationPlayer.play("FadeOut")
		yield($AnimationPlayer, "animation_finished")
		$StartScreen.visible = false
		$Worldspace.visible = true
		$Worldspace.start()
		$AnimationPlayer.play("FadeIn")
		yield($AnimationPlayer, "animation_finished")
	if gameState == "startScreen":
		$Worldspace.stop()
		$AnimationPlayer.play("FadeOut")
		yield($AnimationPlayer, "animation_finished")
		$StartScreen.visible = true
		$Worldspace.visible = false
		$StartScreen.start()
		$AnimationPlayer.play("FadeIn")
		yield($AnimationPlayer, "animation_finished")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
