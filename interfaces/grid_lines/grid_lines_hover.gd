class_name GridLinesHover extends BaseEntity

const common: Common = preload("res://resources/common/common_resource.tres")

var cursor_cell_selection = null
var cursor_hover_cell_selection = null

var tile_map: TileMap = null

func _ready():
	set_name("GridLinesHover")
	set_z_index(common.grid_lines_hover_z_index)

func process_update(delta: float) -> void:
	# Update calls _draw()
	cursor_move_received()
	update()

# We don't use the value emitted by cursor, we get the offseted global mouse position value
func cursor_move_received():
	# Cell position needs to be offset by camera position, camera position is x,y, cell is row,col
	cursor_hover_cell_selection = tile_map.world_to_map(get_global_mouse_position())
	var temp = cursor_hover_cell_selection.x
	cursor_hover_cell_selection.x = cursor_hover_cell_selection.y
	cursor_hover_cell_selection.y = temp

func cursor_click_received(_value):
	# Gets the row, col
	# Cell position needs to be offset by camera position, camera position is x,y, cell is row,col
	cursor_cell_selection = tile_map.world_to_map(get_global_mouse_position())
	var temp = cursor_cell_selection.x
	cursor_cell_selection.x = cursor_cell_selection.y
	cursor_cell_selection.y = temp
	

func draw_cell_outline(cell, color) -> void:
	# On null cell, don't draw anything
	if cell == null:
		return
	# Check if offset cell position is within bounds of grid before drawing
	var tile_size = common.tile_size
	var rect2 = Rect2(Vector2(cell[1], cell[0]) * tile_size, Vector2(tile_size, tile_size))
	draw_rect(rect2, color, false, 2.0)
	
func _draw():	
	# Will draw seperate color for cursor movement vs cursor click
	draw_cell_outline(cursor_hover_cell_selection, Color.yellow)
	draw_cell_outline(cursor_cell_selection, Color.blue)
