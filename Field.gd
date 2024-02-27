extends Sprite2D

var tools_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect("tools", _on_Tools_emitted())
	set_process_input(true) # Enable input processing
	var wheatValue = get_parent().get_node("WheatLabel/WheatValue")



func _input(event):
	if event is InputEventMouseButton:
		var mouse_position = event.position
		if event.button_index == 1:
			if get_rect().has_point(to_local(mouse_position)):
				if event.pressed:
					print("Manually Harvested")
					pressed()
					$"/root/Main".wheatValue += 1
				elif event.is_released:
					released()
					print("released")

func pressed():
	get_parent().get_node("FieldAnimation").play("Click")
	
func released():
	get_parent().get_node("FieldAnimation").play("Release")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
