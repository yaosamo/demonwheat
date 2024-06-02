extends Node2D
# Called when the node enters the scene tree for the first time.
#@export var unitAmount := 0
var timer : float = 0
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var unitAmount = $"/root/Main/".bonuses["Field Worker"].amount
	if unitAmount > 0:
		$unitStart.amount = unitAmount
		$unitStart.emitting = true
		timer += delta
		if timer > 2:
			$unitBack.amount = unitAmount
			$unitBack.emitting = true
	pass
	
	
#func spawnUnit(unitAmount: int):
	#for i in range(unitAmount):
		#$unit.emit_particle(Transform2D(0, self.position), Vector2.ZERO, Color.RED, Color.TRANSPARENT, GPUParticles2D.EMIT_FLAG_POSITION
		#)
