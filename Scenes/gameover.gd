extends Node2D

@onready var game = get_node("/root/GameState")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$deathstats.text = str("You lasted ", game.deathstats[1], " years and gathered ", game.deathstats[0]," wheat")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
