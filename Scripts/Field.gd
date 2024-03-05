extends Sprite2D

var wheatBurst = preload("res://Scenes/wheat_burst.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true) # Enable input processing


func _input(event):
	if event is InputEventMouseButton:
		var mouse_position = event.position
		if event.button_index == 1:
			if get_rect().has_point(to_local(mouse_position)):
				if event.pressed:
					print("Manually Harvested")
					pressed()
					#call main function instead 
					#add visual que
					$"/root/Main".wheatValue += 1
					spawnParticle(mouse_position)
				elif event.is_released:
					released()
					print("released")

func pressed():
	get_parent().get_node("FieldAnimation").play("Click")
	
func released():
	get_parent().get_node("FieldAnimation").play("Release")
	
func spawnParticle(pos: Vector2):
	var new_particle = wheatBurst.instantiate()
	add_child(new_particle)
	new_particle.global_position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
