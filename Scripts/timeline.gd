extends Node2D
# scene for gameover

@export var game_over_scene : PackedScene
@onready var game = get_node("/root/GameState")

@export var demonCallTime : float = 12
var speed : float = 0.5 #0.25 def
var demonsPresented : bool
var maxProgress := 12
var paid := false
var secondTimer := 10
var timer : float = 10
var baseQuota := 30 #199 def hard
var currentProgress
var firstExpEnded : bool
var firstExpStarted : bool
@export var demonQuota : int = 0
var demonTalk = preload("res://Scripts/demontalk.tres")
var dialogue = demonTalk.data["dialogues"]
var fExp_step := 1
	
func _ready():
	firstExpEnded = false
	firstExpStarted = false
	# toggle firstExp on if no save 
	demonQuota = calcQuota()
	$quotaValueDisplay.text = "Demons quota: %d" % demonQuota
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# on demons popup wheat quota
	if firstExpEnded:
		%quotaValue.text = "%d wheat" % demonQuota
			
		if !demonsPresented:
			# Timer
			demonCallTime -= speed*delta
			# Progress in percentages just without multiplying by 100
			currentProgress = demonCallTime/maxProgress
			# Maybe add vector point to get it's position as final point
			$DemonIcon.position.x = lerp(27, 818, currentProgress)
			$timerLabel.text = str(ceil(demonCallTime), " months til demons")
			
		if demonCallTime <= 0 and !demonsPresented:
			$timerLabel.text = "Demons are coming"
			demonCall()
			
		if demonsPresented and %ProgressBar.value > 0:
			# 100/second timer gives me step step to achieve desired seconds (5 for example) 100/5 = 20*delta therefore 5 sec to 100 
			%ProgressBar.value -= (100/secondTimer)*delta
			%lastTimerLabel.text = "Paying in " + str(ceil(%ProgressBar.value/(100/secondTimer)))
			
		if %ProgressBar.value < 1 and !paid:
			paynow()
		
	else:
		if game.wheat > 9 and game.wave == 0 and !firstExpStarted:
			firstExpStarted = true
			demonCall("Oh-oh so you're new farmer here?")
		if game.wave > 0:
			firstExpEnded = true
			

func firstExpFlow(step):
	match step:
		1:
			print_debug("First step")
			%payQ.text = "Yea"
			%vContainerTop.visible = false
			%vContainerBottom.visible = false
			fExp_step += 1
		2:
			print_debug("Second step")
			%talk.text = "I’ll be back in a year and..."
			%payQ.text = "Ok"
			%vContainerTop.visible = true
			fExp_step += 1
		3:
			print_debug("Time to start the game")
			firstExpStarted = false
			firstExpEnded = true
			#reset demon
			demonsPresented = false
			%ProgressBar.value = 100
			$DemAppear.visible = false
			%vContainerBottom.visible = true
			%payQ.visible = false
			
			

func demonCall(talk_text := ""):
	if firstExpStarted:
		firstExpFlow(fExp_step)
	%talk.text = talk_text if talk_text else dialogue.pick_random()
	$DemAppear.visible = true
	demonsPresented = true
	print_debug("hello I am a demon")
	pass
	
	
func death():
	# clear save record
	game.deathstats = [game.wheat, game.wave]
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
	if firstExpStarted:
		firstExpFlow(fExp_step)
	pass 

func paynow():
	if game.wheat >= demonQuota and firstExpEnded:
		game.wheat -= demonQuota
		print_debug("paid")
		paid = true
		demonsPresented = false
		%ProgressBar.value = 100
		$DemAppear.visible = false
		print_debug("Demons are invisible")
		startNextWave()
	else:
		death()

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
	$"/root/Main/".saveGame()
	$"/root/Main/".addBonuses()

func calcQuota() -> int:
	return baseQuota*pow(1.35, game.wave)
