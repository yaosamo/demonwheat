extends Node2D

signal Tools
@export var basecost = 10
@export var costrate = 1
var improvedTools = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Improved tools upd
	$ToolsAmount.text = str(improvedTools)
	$PriceValue.text = str(basecost*costrate)
	pass


# Press button to start timer once
func _on_texture_button_pressed():
	var toolsPrice = basecost*costrate
	# Check if player have enough resource to buy a tool 
	if $"/root/Main".wheatValue >= toolsPrice:
		#take resources
		$"/root/Main".wheatValue -= toolsPrice
		improvedTools += 1
		$"/root/Main"._test(improvedTools)
		print("Tools added: ", improvedTools)
		pass # Replace with function body.
