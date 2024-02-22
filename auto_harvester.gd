extends Node2D

@export var basecost = 10
@export var costrate = 1
var autoharvesters = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#AutoHarvester upd value and label
	Global.wheatValue += 1*autoharvesters*delta
	$HarvestersAmount.text = str(autoharvesters)
	$PriceValue.text = str(basecost*costrate)
	pass


# Press button to start timer once
func _on_texture_button_pressed():
	var harvesterPrice = basecost*costrate
	# Check if player have enough resource to buy a harvester 
	print_debug("Global wheat", Global.wheatValue)
	if Global.wheatValue >= harvesterPrice:
		
		#take resources
		Global.wheatValue -= harvesterPrice
		autoharvesters += 1
		print("Harvesters added: ", autoharvesters)
		pass # Replace with function body.
