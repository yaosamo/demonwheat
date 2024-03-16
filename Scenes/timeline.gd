extends Node2D

@export var demonCallTime : float = 12
var speed : float = 5.0
var demonsPresented : bool
var waveAmount : float = 0
var maxProgress = 12
@export var demonQuota : int = 100

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Timer
	demonCallTime -= speed*delta
	# Progress in percentages just without multiplying by 100
	var currentProgress = demonCallTime/maxProgress
	# Maybe add vector point to get it's position as final point
	$DemonIcon.position.x = lerp(27, 818, currentProgress)
	$timerLabel.text = str(ceil(demonCallTime), " months til demons")
		
	if demonCallTime <= 0:
		demonsPresented = true
		waveAmount += 1
		$timerLabel.text = "Demons are here"
		demonCall()
		# Basically pow function to increase progress
		maxProgress *= 1.25
		demonCallTime = maxProgress
	pass


func demonCall():
	print_debug("wave#:",waveAmount)
	demonQuota = 100*pow(1.25, waveAmount)
	$"/root/Main".wheatValue -= demonQuota
	print_debug("hello I am a demon")
	demonsPresented = false
	$DemonIcon.position.x = maxProgress


