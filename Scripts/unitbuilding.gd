extends Node2D

var timer := 10.0
var speed := 2
var progress := 0.0
var maxposition := 10.0
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


	# Timer
			#demonCallTime -= speed*delta
			## Progress in percentages just without multiplying by 100
			#currentProgress = demonCallTime/maxProgress
			## Maybe add vector point to get it's position as final point
			#$DemonIcon.position.x = lerp(27, 818, currentProgress)
			#$timerLabel.text = str(ceil(demonCallTime), " months til demons")
