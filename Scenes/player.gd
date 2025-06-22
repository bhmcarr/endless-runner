extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	_handle_animation()
	
func jump() -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	
func _handle_animation():
	if not is_on_floor() && velocity.y > 0:
		sprite.play("fall")
	elif not is_on_floor() && velocity.y < 0:
		sprite.play("jump")
	else:
		sprite.play("walk")
		
