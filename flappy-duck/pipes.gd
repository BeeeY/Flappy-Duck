extends Node2D
signal hit
signal scored
var scroll_speed = 150
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= scroll_speed * delta
	if position.x < 100:
		queue_free()


func _on_pipe_bottom_body_entered(body: Node2D) -> void:
	hit.emit()


func _on_pipe_top_body_entered(body: Node2D) -> void:
	hit.emit()


func _on_score_area_body_entered(body: Node2D) -> void:
	scored.emit()
