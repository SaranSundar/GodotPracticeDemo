class_name CameraController extends Camera2D

onready var player = get_parent().get_node("player")

func _ready():
	_set_current(true)

func process_update(delta: float):
	position.x = player.position.x
	position.y = player.position.y
