extends Node2D
signal pipe_hit
signal pipe_scored
@export var pipe_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PipeTimer.paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Quack"):
		$AudioStreamPlayer.play()


func _on_start_game() -> void:
	$Player.spawn($SpawnPoint.position)
	$Player.set_physics_process(false)

	
func _on_hud_game_over() -> void:
	print("game over")
	$PipeTimer.paused = true
	for pipes in get_tree().get_nodes_in_group("Pipes"):
		pipes.queue_free()

func _on_pipe_timer_timeout() -> void:
	# This function is called every time the PipeSpawner timer finishes.
	var pipe = pipe_scene.instantiate()
		# Connect to the pipe's custom signals.
	pipe.hit.connect(pipes_hit)
	pipe.scored.connect(pipes_scored)
	pipe.add_to_group("Pipes")
	# Set a random vertical position for the new pipe.
	pipe.position = Vector2(1152, randi_range(250, 600))
	add_child(pipe)



func _on_hud_countdown_ended() -> void:
	$Player.velocity.y = 0
	$Player.set_physics_process(true)
	$PipeTimer.paused = false

func pipes_hit():
	pipe_hit.emit()
	
func pipes_scored():
	pipe_scored.emit()


func _on_hud_duck_selected():
	$Player.fly_sprite = "duck fly"
	$Player.flap_sprite = "duck flap"
	$Player/AnimatedSprite2D.animation = "duck fly"
	$AudioStreamPlayer.play()

func _on_hud_goose_selected():
	$Player.fly_sprite = "goose fly"
	$Player.flap_sprite = "goose flap"
	$Player/AnimatedSprite2D.animation = "goose fly"
	$AudioStreamPlayer.play()

func _on_hud_mallard_selected() -> void:
	$Player.fly_sprite = "mallard fly"
	$Player.flap_sprite = "mallard flap"
	$Player/AnimatedSprite2D.animation = "mallard fly"
	$AudioStreamPlayer.play()
