extends CharacterBody2D

const SPEED: float = 100.0

@export var player_animation: AnimatedSprite2D
@onready var user_control = $"../UserControl"

# Input stack to track cardinal direction priority
var input_stack: Array[Vector2] = []

func _physics_process(_delta: float) -> void:
	apply_actions()
	
	if DataManager.movement:
		apply_movement()
	else:
		velocity = Vector2.ZERO
		if player_animation:
			player_animation.stop()

	move_and_slide()

func apply_actions() -> void:
	if Input.is_action_just_pressed("ui_esc"):
		user_control.visible = !user_control.visible
		DataManager.movement = !DataManager.movement

func apply_movement() -> void:
	# Update stack on press/release
	_update_input_stack("ui_right", Vector2.RIGHT)
	_update_input_stack("ui_left", Vector2.LEFT)
	_update_input_stack("ui_down", Vector2.DOWN)
	_update_input_stack("ui_up", Vector2.UP)

	var direction := Vector2.ZERO
	if input_stack.size() > 0:
		direction = input_stack.back()

	velocity = direction * SPEED
	update_animation(direction)

func _update_input_stack(action: StringName, dir: Vector2) -> void:
	if Input.is_action_just_pressed(action):
		if not input_stack.has(dir):
			input_stack.append(dir)
	elif Input.is_action_just_released(action):
		input_stack.erase(dir)

func update_animation(direction: Vector2) -> void:
	if not player_animation:
		return

	if direction == Vector2.ZERO:
		player_animation.stop()
		return

	var anim_to_play := player_animation.animation

	if direction.x != 0:
		player_animation.flip_h = (direction.x < 0)
		anim_to_play = "dwn" # Make sure this matches your side animation name
	elif direction.y < 0:
		# We removed player_animation.flip_h = false so it remembers the last facing direction
		anim_to_play = "up"
	elif direction.y > 0:
		# We removed player_animation.flip_h = false so it remembers the last facing direction
		anim_to_play = "dwn"

	if player_animation.animation != anim_to_play or not player_animation.is_playing():
		player_animation.play(anim_to_play)
