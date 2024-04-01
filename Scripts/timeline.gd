extends Node2D

@export var demonCallTime : float = 12
var speed : float = 0.1
var demonsPresented : bool
var waveAmount : float = 0
var maxProgress = 12
var paid = false
@export var demonQuota : int = 100

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !demonsPresented:
		# Timer
		demonCallTime -= speed*delta
		# Progress in percentages just without multiplying by 100
		var currentProgress = demonCallTime/maxProgress
		# Maybe add vector point to get it's position as final point
		$DemonIcon.position.x = lerp(27, 818, currentProgress)
		$timerLabel.text = str(ceil(demonCallTime), " months til demons")
		
	if demonCallTime <= 0 and !demonsPresented:
		$timerLabel.text = "Demons are coming"
		demonCall()
	
	if demonCallTime <= 10 and !$demonsMus.playing:
		$"/root/Main/BgMusic".stop()
		$demonsMus.play()
		pass



func demonCall():
# add 10s timer if not paid by then goto death
	$DemAppear.visible = true
	demonsPresented = true
	print_debug("hello I am a demon")
	
	var lastCallTimer = 0
	if lastCallTimer <= 0 and !paid:
		death()
	
	
func death():
	pass


func _on_pay_q_pressed() -> void:
	$"/root/Main".wheatValue -= demonQuota
	print_debug("paid")
	paid = true
	demonsPresented = false
	$DemAppear.visible = false
	$demonsMus.stop()
	startNextWave()
	pass # Replace with function body.


func startNextWave():
	# next wave
	waveAmount += 1
	print_debug("starting wave#:",waveAmount)
	# increase quota
	demonQuota = 100*pow(1.25, waveAmount)
	# deadline
	maxProgress *= 1.25
	demonCallTime = maxProgress
	# move to starting point
	$DemonIcon.position.x = maxProgress
	$"/root/Main/BgMusic".play()
