class_name Cursor extends Node2D

# Load Resources
const common: Common = preload("res://resources/common/common_resource.tres")

# Cursor Arrow Image
const cursor_icon = preload("res://assets/cursor_rotated.png")

# Cursor x, y, with 0,0 being top left of screen and
# 	width, height being bottom right of screen
var cursor_position = Vector2(0, 0)
var cursor_click_position = Vector2(0, 0)

signal cursor_moved(position)
signal cursor_clicked(position)

func _ready():
	setup_cursor()

func setup_cursor():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_use_accumulated_input(false)
	Input.set_custom_mouse_cursor(cursor_icon, Input.CURSOR_ARROW, Vector2(0,80))
	self.set_z_index(common.cursor_z_index)
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.pressed:
		cursor_click_position = event.position
		global_position = cursor_position
		emit_signal("cursor_clicked", cursor_click_position)
	elif event is InputEventMouseMotion:
		cursor_position = event.position
		global_position = cursor_position
		emit_signal("cursor_moved", cursor_position)
		
