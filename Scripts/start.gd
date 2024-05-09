extends Node2D

@export var target_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartCtrl.connect("gui_input", pressed.bind())
	pass # Replace with function body.

func pressed():
	print_debug("HI")
	if !target_scene:
		print("no next scene here")
	else:
		next_scene()
		
func hover():
	$AnimationPlayer.play("StartButton")

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
