extends Sprite2D

var tools_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect("tools", _on_Tools_emitted())
	set_process_input(true) # Enable input processing
	var wheatValue = get_parent().get_node("WheatLabel/WheatValue")
	

func _on_Tools_emitted():
	print("Tools signal emitted!")

func _input(event):
	if event is InputEventMouseButton:
		var mouse_position = event.position
		if event.pressed and event.button_index == 1:
# check if mouse if over sprite
			if get_rect().has_point(to_local(mouse_position)):
				print("Manually Harvested")
				Global.wheatValue += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


