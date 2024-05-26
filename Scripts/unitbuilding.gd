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
	var pos_goal = get_parent().get_node("unit_br_goal").position
	var pos_start = get_parent().get_node("unit_br_start").position

	timer -= speed*delta
	progress = timer/maxposition

	#$unit.position.x = lerp(27, pos_start.x, progress)
	#if $unit.position.x > pos_start.x:
	$unit.position.x = lerp(574, int(pos_start.x), progress)
	#$unit.position.y = lerp(int(pos_goal.y_, int(pos_start.y), progress)
	
	#$unit.global_position.y = lerp(10, 20, progress)
	
	print_debug("Unit pos ", $unit.global_position)
	pass


	# Timer
			#demonCallTime -= speed*delta
			## Progress in percentages just without multiplying by 100
			#currentProgress = demonCallTime/maxProgress
			## Maybe add vector point to get it's position as final point
			#$DemonIcon.position.x = lerp(27, 818, currentProgress)
			#$timerLabel.text = str(ceil(demonCallTime), " months til demons")
