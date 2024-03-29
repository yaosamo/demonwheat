extends Node2D

@export var target_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("pressed", pressed.bind())
	$Button.connect("mouse_entered", hover.bind())
	pass # Replace with function body.

func pressed():
	if !target_scene:
		print("no next scene here")
	else:
		next_scene()
		
func hover():
	$AnimationPlayer.play("StartButton")
		
func next_scene():
	var ERR = get_tree().change_scene_to_packed(target_scene)
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
