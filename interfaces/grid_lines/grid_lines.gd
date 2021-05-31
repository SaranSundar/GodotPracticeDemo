class_name GridLines extends BaseEntity

const common: Common = preload("res://resources/common/common_resource.tres")
const grid_data: GridData = preload("res://resources/grid_data/grid_data_resource.tres")

var cursor_cell_selection = null
var cursor_hover_cell_selection = null
var bfs: Dictionary = {}

func _ready():
	set_name("GridLines")
	set_z_index(common.grid_lines_z_index)

# Virtual function. Corresponds to the `_process()` callback.
func process_update(delta: float) -> void:
	update()
	
func cursor_move_received(position):
	cursor_hover_cell_selection = grid_data.get_cell_bounds(position, common.tile_size)

func cursor_click_received(position):
	# Gets the row, col
	cursor_cell_selection = grid_data.get_cell_bounds(position, common.tile_size)

func update_bfs(bfs: Dictionary):
	self.bfs = bfs
	

func draw_cell_outline(cell, color) -> void:
	# On null cell, don't draw anything
	if not cell:
		return
	var tile_size = common.tile_size
	var rect2 = Rect2(Vector2(cell[1], cell[0]) * tile_size, Vector2(tile_size, tile_size))
	draw_rect(rect2, color, false, 2.0)
	
func draw_grid_outline():
	for r in range(len(grid_data.current_level) + 1):
		var left_grid = Vector2.ZERO
		var right_grid = Vector2.ZERO
		left_grid.y = r * common.tile_size
		right_grid.x = len(grid_data.current_level[0]) * common.tile_size
		right_grid.y = r * common.tile_size
		draw_line(left_grid, right_grid, Color.red, 1, true)
	
	for c in range(len(grid_data.current_level[0]) + 1):
		var top_grid = Vector2.RIGHT * c * common.tile_size
		var bottom_grid = top_grid + Vector2.DOWN * len(grid_data.current_level) * common.tile_size
		draw_line(top_grid, bottom_grid, Color.red, 1, true)
	
func _draw():
	# Draws outline of entire grid
	draw_grid_outline()
	
	# Will draw range of characters movement options
	for key in bfs:
		draw_cell_outline(bfs[key].position, Color.purple)
	
	# Will draw seperate color for cursor movement vs cursor click
	draw_cell_outline(cursor_hover_cell_selection, Color.yellow)
	draw_cell_outline(cursor_cell_selection, Color.blue)
