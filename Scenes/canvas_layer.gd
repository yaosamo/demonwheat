extends CanvasLayer
var progress: float = 0.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_rect(Rect2(Vector2(0, 0), Vector2(progress, 40)), Color(0.2, 0.6, 0.9))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
