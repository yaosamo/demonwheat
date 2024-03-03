@tool

extends Node2D

@export var bonusname: String
@export var price: int
@export var amount : int
@export var baseprice : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Title.text = bonusname
	$PriceValue.text = str(price)
	$Amount.text = str(amount)
	pass
