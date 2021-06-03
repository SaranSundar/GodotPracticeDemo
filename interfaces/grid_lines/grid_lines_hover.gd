class_name GridLinesHover extends BaseEntity

const common: Common = preload("res://resources/common/common_resource.tres")

var cursor_cell_selection = null
var cursor_hover_cell_selection = null
var bfs: Dictionary = {}
var tile_map: TileMap = null
var cursor_path: Array = []


func _ready():
	set_name("GridLinesHover")
	set_z_index(common.grid_lines_hover_z_index)

func process_update(delta: float) -> void:
	# Update calls _draw()
	cursor_move_received()
	update()

func reflect_vector(vector: Vector2):
	return Vector2(vector.y, vector.x)
	
# We don't use the value emitted by cursor, we get the offseted global mouse position value
func get_mouse_pos_as_tile_coords():
	# This returns coordinates as x,y.
	var coords: Vector2 = tile_map.world_to_map(get_global_mouse_position())
	# Convert x,y to row, col
	coords = reflect_vector(coords)
	return coords
	
# Mouse hover called every frame
func cursor_move_received():
	cursor_hover_cell_selection = get_mouse_pos_as_tile_coords()

func cursor_click_received(_value):
	cursor_cell_selection = get_mouse_pos_as_tile_coords()
	get_cursor_drawing_path()

func get_cursor_drawing_path():
	var path = []
	var end = cursor_cell_selection
	while end in bfs:
		path.append((reflect_vector(end) * common.tile_size) + Vector2.ONE * common.tile_size / 2)
		end = bfs[end].prev_grid_node
		if end != null:
			end = end.position
	
	cursor_path = path

func array_to_curve(input : Array, dist : float) -> Curve2D:
	#dist determines length of controls, set dist = 0 for no smoothing
	var curve = Curve2D.new()

	#calculate first point
	var start_dir = input[0].direction_to(input[1])
	curve.add_point(input[0], - start_dir * dist, start_dir * dist)

	#calculate middle points
	for i in range(1, input.size() - 1):
		var dir = input[i-1].direction_to(input[i+1])
		curve.add_point(input[i], -dir * dist, dir * dist)

	#calculate last point
	var end_dir = input[-1].direction_to(input[-2])
	curve.add_point(input[-1], - end_dir * dist, end_dir * dist)

	return curve

func array_to_line(input : Array, dist : float) -> Line2D:
	#dist determines length of controls, set dist = 0 for no smoothing
	var curve = Line2D.new()

	#calculate first point
	var start_dir = input[0].direction_to(input[1])
	curve.add_point(input[0])

	#calculate middle points
	for i in range(1, input.size() - 1):
		var dir = input[i-1].direction_to(input[i+1])
		curve.add_point(input[i])

	#calculate last point
	var end_dir = input[-1].direction_to(input[-2])
	curve.add_point(input[-1])

	return curve

func draw_path():
	if cursor_path:
		draw_polyline(array_to_line(cursor_path, 0).points, Color.black, 2.0)

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
	draw_path()
