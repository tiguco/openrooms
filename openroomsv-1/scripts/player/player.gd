extends CharacterBody3D

@export_range(0.1, 20.0, 0.1) var movement_speed: float = 5.0
@export_range(0.0001, 0.01, 0.0001) var mouse_sensitivity: float = 0.002

@onready var head: Node3D = $Head


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"release_mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_viewport().set_input_as_handled()
		return

	if event is InputEventMouseButton:
		var mouse_button := event as InputEventMouseButton
		if mouse_button.button_index == MOUSE_BUTTON_LEFT and mouse_button.pressed:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_viewport().set_input_as_handled()
			return

	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouse_motion := event as InputEventMouseMotion
		rotate_y(-mouse_motion.relative.x * mouse_sensitivity)
		head.rotate_x(-mouse_motion.relative.y * mouse_sensitivity)
		head.rotation.x = clampf(head.rotation.x, deg_to_rad(-85.0), deg_to_rad(85.0))
		get_viewport().set_input_as_handled()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0.0

	var input_direction := Input.get_vector(
		&"move_left",
		&"move_right",
		&"move_forward",
		&"move_backward"
	)
	var movement_direction := (transform.basis * Vector3(input_direction.x, 0.0, input_direction.y)).normalized()

	velocity.x = movement_direction.x * movement_speed
	velocity.z = movement_direction.z * movement_speed
	move_and_slide()
