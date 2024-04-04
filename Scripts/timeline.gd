extends Node2D
# scene for gameover
@export var game_over_scene : PackedScene

@export var demonCallTime : float = 12
var speed : float = 2
var demonsPresented : bool
var waveAmount : float = 0
var maxProgress = 12
var paid = false
var secondTimer = 5
@export var demonQuota : int = 100
var demonTalk = preload("res://Scripts/demontalk.tres")

func _ready():
	for talk in demonTalk.data["dialogues"]:
		$DemAppear/talk.text = talk
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# on demons popup wheat quota
	$DemAppear/quotaValue.text = str(demonQuota, " wheat")

	if !demonsPresented:
		# Timer
		demonCallTime -= speed*delta
		# Progress in percentages just without multiplying by 100
		var currentProgress = demonCallTime/maxProgress
		# Maybe add vector point to get it's position as final point
		$DemonIcon.position.x = lerp(27, 818, currentProgress)
		$timerLabel.text = str(ceil(demonCallTime), " months til demons")
	
	#music stop and play when demons arrive	
	if demonCallTime <= 4 and !$demonsMus.playing:
		$"/root/Main/BgMusic".stop() 
		$demonsMus.play()
		pass
		
	if demonCallTime <= 0 and !demonsPresented:
		$timerLabel.text = "Demons are coming"
		demonCall()
		
	if demonsPresented and $DemAppear/ProgressBar.value < 100:
		#100/second timer gives me step step to achieve desired seconds (5 for example) 100/5 = 20*delta therefore 5 sec to 100 
		$DemAppear/ProgressBar.value += (100/secondTimer)*delta
		$DemAppear/lastTimerLabel.text = "Give up in.." + str(ceil(secondTimer-($DemAppear/ProgressBar.value/(100/secondTimer))))
		
	if $DemAppear/ProgressBar.value >= 100 and !paid:
		death()



func demonCall():
# add 10s timer if not paid by then goto death
	$DemAppear.visible = true
	demonsPresented = true
	print_debug("hello I am a demon")
	
	
func death():
	print_debug("You're dead")
	$DemAppear.visible = false
	var ERR = get_tree().change_scene_to_packed(game_over_scene)
	pass


func _on_pay_q_pressed() -> void:
	$"/root/Main".wheatValue -= demonQuota
	print_debug("paid")
	paid = true
	demonsPresented = false
	$DemAppear/ProgressBar.value = 0
	$DemAppear.visible = false
	$demonsMus.stop()
	startNextWave()
	pass 


func startNextWave():
	# next wave
	waveAmount += 1
	print_debug("starting wave#:",waveAmount)
	# increase quota
	demonQuota = 100*pow(1.25, waveAmount)
	# deadline
	maxProgress *= 1.25
	paid = false
	demonCallTime = maxProgress
	# move to starting point
	$DemonIcon.position.x = maxProgress
	$"/root/Main/BgMusic".play()

