extends Sprite2D

var wheatBurst = preload("res://Scenes/wheat_burst.tscn")
var hitvalue = preload("res://Scenes/hit_value.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("Im 2nd?")
	set_process_input(true) # Enable input processing

func pressed():
	get_parent().get_node("FieldAnimation").play("Click")
	
func released():
	get_parent().get_node("FieldAnimation").play("Release")
	
func spawnParticle(pos: Vector2):
	var new_particle = wheatBurst.instantiate()
	var new_hitvalue = hitvalue.instantiate()
	new_hitvalue.amount = "+1"
	add_child(new_particle)
	add_child(new_hitvalue)
	new_particle.global_position = pos
	new_hitvalue.global_position = pos
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
