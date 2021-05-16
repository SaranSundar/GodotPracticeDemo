class_name Cursor extends Node2D

# Load Resources
const grid_data: GridData = preload("res://resources/grid_data/grid_data_resource.tres")
const common: Common = preload("res://resources/common/common_resource.tres")

# Cursor Arrow Image
const cursor_icon = preload("res://assets/cursor_rotated.png")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_use_accumulated_input(false)
	Input.set_custom_mouse_cursor(cursor_icon, Input.CURSOR_ARROW, Vector2(40, 120))
	self.set_z_index(common.cursor_z_index)

