extends CharacterBody2D

class_name Player

@onready var sprite_2d: Sprite2D = $Sprite2D

const GRAVITY: float = 690
const JUMP_SPEED: float = -270.0
const RUN_SPEED: float = 120.0

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_SPEED
	
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0
	
	move_and_slide()
