extends Node2D


var gameState = "StartScreen"

# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimationPlayer.play("FadeIn")
	changeGameState("StartScreenNoFade")
	

func changeGameState(state):
	gameState = state
	if gameState == "Play":
		$StartScreen.stop()
		$AnimationPlayer.play("FadeOut")
		$StartScreen/AudioStreamPlayer.stop()
		yield($AnimationPlayer, "animation_finished")
		$StartScreen.visible = false
		$Worldspace.visible = true
		$Worldspace.start()
		$AnimationPlayer.play("FadeIn")
		yield($AnimationPlayer, "animation_finished")
	if gameState == "StartScreen":
		$Worldspace.stop()
		$AnimationPlayer.play("FadeOut")
		yield($AnimationPlayer, "animation_finished")
		$CreditsScreen.stop()
		$StartScreen.visible = true
		$Worldspace.visible = false
		$StartScreen.start()
		$AnimationPlayer.play("FadeIn")
		yield($AnimationPlayer, "animation_finished")
		$StartScreen/AudioStreamPlayer.play()
		
	if gameState == "StartScreenNoFade":
		$StartScreen/AudioStreamPlayer.play()
		$Worldspace.stop()
		$StartScreen.visible = true
		$Worldspace.visible = false
		$StartScreen.start()
		$AnimationPlayer.play("FadeIn")
		yield($AnimationPlayer, "animation_finished")
		gameState = "StartScreen"
	
	if gameState == "Credits":
		$StartScreen/AudioStreamPlayer.stop()
		$AnimationPlayer.play("FadeOut")
		yield($AnimationPlayer, "animation_finished")
		$Worldspace.stop()
		$StartScreen.visible = false
		$Worldspace.visible = false
		$CreditsScreen.start()
		$AnimationPlayer.play("FadeIn")
		yield($AnimationPlayer, "animation_finished")
		gameState = "Credits"
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
