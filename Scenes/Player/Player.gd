extends CharacterBody2D

class_name Player

@export var fell_off_y: float = 800.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel

const GRAVITY: float = 690
const JUMP_SPEED: float = -270.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 350.0

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_SPEED
	
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0
	
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)
	
	move_and_slide()
	update_debug_label()
	fallen_off()

func fallen_off() -> void:
	if global_position.y > fell_off_y:
		queue_free()

func update_debug_label() -> void:
	var ds: String = ""
	ds += "Floor: %s\n" % [is_on_floor()]
	ds += "V: %.1f, %.1f\n" % [velocity.x, velocity.y]
	ds += "P: %.1f, %.1f" % [global_position.x, global_position.y]
	debug_label.text = ds
