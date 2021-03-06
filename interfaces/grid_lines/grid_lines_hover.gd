class_name GridLinesHover extends BaseEntity

const common: Common = preload("res://resources/common/common_resource.tres")

var cursor_cell_selection = null
var cursor_hover_cell_selection = null
var bfs: Dictionary = {}
var tile_map: TileMap = null
var cursor_path: Array = []

var is_active_state = false

signal start_animation

var animating_player = false


func _ready():
	set_name("GridLinesHover")
	set_z_index(common.grid_lines_hover_z_index)

func process_update(delta: float) -> void:
	if not is_active_state:
		return
	# Update calls _draw()
	if not animating_player:
		# Don't draw new path while player is moving
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
	# TODO: Optimize so you don't keep recalculating the same path if you move cursor around,
	# optionally have a cache of paths or precalculate all paths
	var mouse_coords = get_mouse_pos_as_tile_coords()
	if mouse_coords in bfs:
		cursor_hover_cell_selection = mouse_coords
		get_cursor_drawing_path()
	else:
		cursor_hover_cell_selection = null
		cursor_path = []

func cursor_click_received(_value):
	if not is_active_state:
		return
	# Don't listen to mouse clicks while player is animating and moving
	if animating_player:
		return
	
	var mouse_coords = get_mouse_pos_as_tile_coords()
	if mouse_coords in bfs:
		cursor_cell_selection = mouse_coords
		# Parent class will set this to false when animation is done
		animating_player = true
		emit_signal("start_animation")
	else:
		cursor_cell_selection = null

func get_cursor_drawing_path():
	var path = []
	var end = cursor_hover_cell_selection
	var offset: Vector2 = Vector2.ONE * common.tile_size / 2
	while end in bfs:
		# Origin is top left of cell
		var origin: Vector2 = reflect_vector(end) * common.tile_size
		# We want to get mid point of cell
		var midpoint = origin + offset
		path.append(midpoint)
		end = bfs[end].prev_grid_node
		if end != null:
			end = end.position
	
	# This will insert point in between every existing point
	var i = 1
	var length = len(path)
	while i < length:
		var prev = path[i-1]
		var curr = path[i]
		var mid: Vector2
		if prev.x == curr.x:
			mid = Vector2(curr.x, (curr.y + prev.y)/2)
		else:
			mid = Vector2((curr.x + prev.x)/2, curr.y)
		path.insert(i, mid)
		length = len(path)
		i += 2
	
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
		for i in range(len(cursor_path) -1, -1, -1):
			var point = cursor_path[i]
			var radius = 1.5
			if i == 0:
				radius = 2
			draw_circle(point, radius, Color.white)
		# draw_polyline(array_to_line(cursor_path, 0).points, Color.black, 2.0)

func draw_cell_hover_sprite():
	# TODO: Replace with sword sprite
	if cursor_hover_cell_selection:
		var offset: Vector2 = Vector2.ONE * common.tile_size / 2
		var dest = reflect_vector(cursor_hover_cell_selection) * common.tile_size
		dest += offset
		draw_circle(dest, 2.5, Color.aqua)

func draw_cell_outline(cell, color) -> void:
	# On null cell, don't draw anything
	if cell == null:
		return
	# Check if offset cell position is within bounds of grid before drawing
	var tile_size = common.tile_size
	var rect2 = Rect2(reflect_vector(cell) * tile_size, Vector2(tile_size, tile_size))
	draw_rect(rect2, color, false, 2.0)
	
func _draw():
	if not is_active_state:
		return
	
	# Will draw range of characters movement options
	for key in bfs:
		draw_cell_outline(bfs[key].position, Color.purple)
		
	#TODO: Draw sword or cursor for end of path here
	draw_cell_outline(cursor_cell_selection, Color.blue)
	draw_path()
	draw_cell_hover_sprite()
