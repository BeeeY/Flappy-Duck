extends CharacterBody2D
var flap_sprite = "duck flap"
var fly_sprite = "duck fly"
func _ready():
	$AnimatedSprite2D.animation = fly_sprite
const SPEED = 300.0
const JUMP_VELOCITY = -500.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Flap"):
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = flap_sprite
		await get_tree().create_timer(0.2).timeout
		$AnimatedSprite2D.animation = fly_sprite
		
	move_and_slide()

func spawn(pos):
	position = pos
