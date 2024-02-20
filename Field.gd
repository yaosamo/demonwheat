extends Sprite2D
var wheatValue: Label
var AutoHarvester: Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true) # Enable input processing
	wheatValue = get_parent().get_node("WheatLabel/WheatValue")

func _input(event):
	if event is InputEventMouseButton:
		var mouse_position = event.position
		if event.pressed and event.button_index == 1:
# check if mouse if over sprite
			if get_rect().has_point(to_local(mouse_position)):
				print("Harvested")
				Global.count += 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	wheatValue.text = str(Global.count)
	pass


