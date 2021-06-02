class_name GridLines extends BaseEntity

const common: Common = preload("res://resources/common/common_resource.tres")

var cursor_cell_selection = null
var cursor_hover_cell_selection = null
var bfs: Dictionary = {}
var current_level = null

var tile_map: TileMap = null

func _ready():
	set_name("GridLines")
	set_z_index(common.grid_lines_z_index)

func update_bfs(bfs: Dictionary):
	self.bfs = bfs
	

func draw_cell_outline(cell, color) -> void:
	# On null cell, don't draw anything
	if cell == null:
		return
	# Check if offset cell position is within bounds of grid before drawing
	var tile_size = common.tile_size
	var rect2 = Rect2(Vector2(cell[1], cell[0]) * tile_size, Vector2(tile_size, tile_size))
	draw_rect(rect2, color, false, 2.0)
	
func draw_grid_outline():
	for r in range(len(current_level) + 1):
		var left_grid = Vector2.ZERO
		var right_grid = Vector2.ZERO
		left_grid.y = r * common.tile_size
		right_grid.x = len(current_level[0]) * common.tile_size
		right_grid.y = r * common.tile_size
		draw_line(left_grid, right_grid, Color.red, 1, true)
	
	for c in range(len(current_level[0]) + 1):
		var top_grid = Vector2.RIGHT * c * common.tile_size
		var bottom_grid = top_grid + Vector2.DOWN * len(current_level) * common.tile_size
		draw_line(top_grid, bottom_grid, Color.red, 1, true)
	
func _draw():
	# Draws outline of entire grid
	draw_grid_outline()
	
	# Will draw range of characters movement options
	for key in bfs:
		draw_cell_outline(bfs[key].position, Color.purple)
