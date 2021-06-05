class_name CameraController extends Camera2D

onready var player = get_parent().get_node("player")
onready var curve: Curve2D  = get_parent().get_node("Path2D").curve
onready var follow: PathFollow2D = get_parent().get_node("Path2D/PathFollow2D")

var allow_free_movement = false
# Movement variables
const ACCELERATION = 1
const MAX_SPEED = 5
const FRICTION = 500

var velocity = Vector2.ZERO
var input_vector = Vector2(0, 0)

func _ready():
	_set_current(true)

func process_update(delta: float):
	if allow_free_movement:
		free_movement(delta)
	else:
		position.x = follow.position.x
		position.y = follow.position.y
	

func free_movement(delta: float):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	position += input_vector * MAX_SPEED
