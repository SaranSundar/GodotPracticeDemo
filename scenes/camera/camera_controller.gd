class_name CameraController extends Camera2D

onready var player = get_parent().get_node("player")

func _ready():
	self._set_current(true)

func update_camera(delta):
	position.x = player.position.x
	position.y = player.position.y
