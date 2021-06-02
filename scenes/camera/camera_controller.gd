class_name CameraController extends Camera2D

onready var player = get_parent().get_node("player")
onready var curve: Curve2D  = get_parent().get_node("Path2D").curve
onready var follow: PathFollow2D = get_parent().get_node("Path2D/PathFollow2D")

func _ready():
	_set_current(true)

func process_update(delta: float):
	# TODO: This may or may not work
	# print(player.position, follow.position)
	position.x = follow.position.x
	position.y = follow.position.y
	
