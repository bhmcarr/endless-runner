extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var powerup_timer: Timer = $PowerupTimer

const SPEED = 300.0
const JUMP_VELOCITY = -400

enum states {NORMAL, FLYING}

var current_state = states.NORMAL

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	_handle_animation()
	
func jump() -> void:
	if (current_state == states.NORMAL && is_on_floor()) || current_state == states.FLYING:
		velocity.y = JUMP_VELOCITY
	
func _handle_animation():
	if current_state == states.NORMAL:
		if not is_on_floor() && velocity.y > 0:
			sprite.play("fall")
		elif not is_on_floor() && velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("walk")
	elif current_state == states.FLYING:
		if not is_on_floor() && velocity.y > 0:
			sprite.play("fall_fly")
		elif not is_on_floor() && velocity.y < 0:
			sprite.play("jump_fly")
		else:
			sprite.play("walk")
		
func activate_flying():
	current_state = states.FLYING
	powerup_timer.start()
	
func _on_powerup_timer_timeout() -> void:
	current_state = states.NORMAL
