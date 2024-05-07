extends Node2D
# scene for gameover

@export var game_over_scene : PackedScene
@onready var game = get_node("/root/GameState")

@export var demonCallTime : float = 12
var speed : float = 2.25 #0.25 def
var demonsPresented : bool
var maxProgress = 12
var paid = false
var secondTimer = 10
var baseQuota = 19 #199 def
var currentProgress
@export var demonQuota : int = 0
var demonTalk = preload("res://Scripts/demontalk.tres")
var dialogue = demonTalk.data["dialogues"]

func _ready():
	demonQuota = calcQuota()
	$quotaValueDisplay.text = "Demons quota: %d" % demonQuota
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# on demons popup wheat quota
	$DemAppear/quotaValue.text = "%d wheat" % demonQuota

	if !demonsPresented:
		# Timer
		demonCallTime -= speed*delta
		# Progress in percentages just without multiplying by 100
		currentProgress = demonCallTime/maxProgress
		# Maybe add vector point to get it's position as final point
		$DemonIcon.position.x = lerp(27, 818, currentProgress)
		$timerLabel.text = str(ceil(demonCallTime), " months til demons")

	# music stop and play when demons arrive
	# if demonCallTime <= 4 and !$demonsMus.playing:
		#$"/root/Main/BgMusic".stop()
		#$demonsMus.play()
		#pass

	if demonCallTime <= 0 and !demonsPresented:
		$timerLabel.text = "Demons are coming"
		demonCall()

	if demonsPresented and $DemAppear/ProgressBar.value > 0:
		# 100/second timer gives me step step to achieve desired seconds (5 for example) 100/5 = 20*delta therefore 5 sec to 100 
		$DemAppear/ProgressBar.value -= (100/secondTimer)*delta
		$DemAppear/lastTimerLabel.text = "Give up in.." + str(ceil($DemAppear/ProgressBar.value/(100/secondTimer)))

	if $DemAppear/ProgressBar.value < 1 and !paid:
		death()


func demonCall():
	# calculating size of the bubble
	var SpeechNum = randi() % dialogue.size()
	var Speech = dialogue[SpeechNum]
	$DemAppear/talk.text = Speech
	$DemAppear/talkBubble.size = Vector2($DemAppear/talk.size.x+24, $DemAppear/talk.size.y-4)
	# add 10s timer if not paid by then goto death
	$DemAppear.visible = true
	demonsPresented = true
	print_debug("hello I am a demon")
	pass
	
	
func death():
	# clear save record
	game.wheat = 0
	game.wave = 0
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var saveNode = {}
	var json_string = JSON.stringify(saveNode)
	save_file.store_line(json_string)
	print_debug("Reseting save file")
	print_debug("You're dead")
	$DemAppear.visible = false
	var ERR = get_tree().change_scene_to_packed(game_over_scene)
	pass


func _on_pay_q_pressed() -> void:
	#check if wheat is available
	if game.wheat >= demonQuota:
		game.wheat -= demonQuota
		print_debug("paid")
		paid = true
		demonsPresented = false
		$DemAppear/ProgressBar.value = 100
		$DemAppear.visible = false
		print_debug("Demons are invisible")
		$demonsMus.stop()
		startNextWave()
	pass 


func startNextWave():
	# next wave
	game.wave += 1
	$"/root/Main/yearLabel".text = str("Year ", game.wave+1)
	print_debug("starting year#:",game.wave)
	# increase quota
	demonQuota = calcQuota()
	$quotaValueDisplay.text = "Demons quota: %d" % demonQuota
	paid = false
	demonCallTime = maxProgress
	# move to starting point
	$DemonIcon.position.x = maxProgress
	$"/root/Main/BgMusic".play()
	$"/root/Main/".saveGame()
	$"/root/Main/".addBonuses()

func calcQuota() -> int:
	return baseQuota*pow(1.25, game.wave)
