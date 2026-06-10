extends CharacterBody2D


const WALK_SPEED = 300.0
const RUN_SPEED = 500.0
const JUMP_VELOCITY = -600.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func die():
	get_tree().reload_current_scene()

func _ready() -> void:
	print("Você é viado")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	var current_speed = WALK_SPEED

	if Input.is_action_pressed("run"):
		current_speed = RUN_SPEED
	
	# Inverte o sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# Altera a animação
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			if Input.is_action_pressed("run"):
				animated_sprite_2d.play("run")
			else:
				animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)



	move_and_slide()
