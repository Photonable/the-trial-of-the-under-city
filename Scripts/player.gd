extends CharacterBody3D


const SPEED : float = 10.0
const JUMP_VELOCITY : float = 4.5
const LOOK_SPEED : float = 0.002

var look_rotation : Vector2
var move_speed : float = 0.0

var mouse_captured : bool = true


@onready var head : Node3D = $Head

func _ready() -> void:
	look_rotation.y = rotation.y
	look_rotation.x = head.rotation.x
	
	capture_mouse()
	
func _unhandled_input(event: InputEvent) -> void:
	# Mouse capturing
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
		
	if mouse_captured and event is InputEventMouseMotion:
		rotate_look(event.relative)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if mouse_captured and direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)	
		
	move_and_slide()
	
func rotate_look(rot_input : Vector2):
	look_rotation.x -= rot_input.y * LOOK_SPEED
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-85), deg_to_rad(60))
	look_rotation.y -= rot_input.x * LOOK_SPEED
	transform.basis = Basis()
	rotate_y(look_rotation.y)
	head.transform.basis = Basis()
	head.rotate_x(look_rotation.x)
	
func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true
	
func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
