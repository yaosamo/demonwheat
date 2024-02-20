extends Node2D

var harvested = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Timer goes off each second and adds +1 to autoharvester
func _on_timer_timeout():
	Global.count += 1
	print("Auto-Harvested: ", Global.count)
	pass # Replace with function body.

# Press button to start timer once
func _on_texture_button_pressed():
	if $Timer.is_stopped():
		print("Starting timer")
		$Timer.start()
	print("Timer is already started")
	pass # Replace with function body.
