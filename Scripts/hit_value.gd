extends Node2D
@export var amount : String

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("Hit amount",amount)
	$Label.text = amount
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_finished(anim_name):
	self.queue_free()
	pass # Replace with function body.
