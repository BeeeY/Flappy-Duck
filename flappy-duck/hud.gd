extends CanvasLayer
signal start_game
signal game_over
signal countdown_ended
signal duck_selected
signal goose_selected
signal mallard_selected
var score
var game_start = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Score.hide()
	$Countdown.hide()
	$Space.hide()
	$Duck.hide()
	$Goose.hide()
	$Mallard.hide()
	$Back.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$Title.hide()
	$Backround.hide()
	$DuckSelect.hide()
	score = 0
	$Score.text = "0"
	$Score.show()
	$Countdown.text = "3"
	$Countdown.show()
	$Space.show()
	game_start = true
	start_game.emit()
	await get_tree().create_timer(1).timeout
	$Countdown.text = "2"
	await get_tree().create_timer(1).timeout
	$Countdown.text = "1"
	await get_tree().create_timer(1).timeout
	$Countdown.hide()
	$Space.hide()
	countdown_ended.emit()
	
func update_score():
	$Score.text = str(score)


func _on_pipes_scored() -> void:
	score += 1
	update_score()


func _on_pipes_hit() -> void:
	$Title.text = "Game Over"
	$Title.show()
	$StartButton.show()
	$Backround.show()
	game_start = false
	game_over.emit()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if game_start == true:
		$Title.text = "Game Over"
		$Title.show()
		$StartButton.show()
		$Backround.show()
		game_start = false
		game_over.emit()


func _on_main_pipe_hit() -> void:
	if game_start == true:
		$Title.text = "Game Over"
		$Title.show()
		$StartButton.show()
		$Backround.show()
		game_start = false
		game_over.emit()


func _on_main_pipe_scored() -> void:
	_on_pipes_scored()


func _on_duck_select_pressed() -> void:
	$Title.hide()
	$StartButton.hide()
	$DuckSelect.hide()
	$Duck.show()
	$Goose.show()
	$Mallard.show()
	$Back.show()
	
func _on_back_pressed() -> void:
	$Duck.hide()
	$Goose.hide()
	$Mallard.hide()
	$Back.hide()
	$Title.show()
	$StartButton.show()
	$DuckSelect.show()

func _on_duck_pressed() -> void:
	duck_selected.emit()

func _on_goose_pressed() -> void:
	goose_selected.emit()
	
func _on_mallard_pressed() -> void:
	mallard_selected.emit()
