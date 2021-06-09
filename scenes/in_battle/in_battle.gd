class_name InBattleScene extends BaseEntity

const common: Common = preload("res://resources/common/common_resource.tres")

onready var custom_tile_map: CustomTileMap = $custom_tile_map
onready var player: Player = $player
onready var camera: CameraController = $camera
onready var grid_lines: GridLines = $GridLines
onready var grid_lines_hover: GridLinesHover = $GridLinesHover

# Used to move players around on the map
onready var curve: Curve2D  = $Path2D.curve
onready var follow: PathFollow2D = $Path2D/PathFollow2D
export var path_follow_speed: int = 60

signal movement_ended

func _ready():
	set_name("InBattleScene")
	setup_grid_lines()
	camera.allow_free_movement = true

func setup_grid_lines():
	connect_cursor_to_grid_lines_hover()
	grid_lines.current_level = custom_tile_map.generate_dummy_map_data()
	grid_lines.tile_map = custom_tile_map.background_map
	grid_lines_hover.tile_map = custom_tile_map.background_map
	grid_lines_hover.connect("start_animation", self, "start_animation")
	

func connect_cursor_to_grid_lines_hover():
	var cursor: Cursor = get_node("/root/main/cursor")
	cursor.connect("cursor_clicked", grid_lines_hover, "cursor_click_received")

func process_update(delta: float):
	# Cursor is moving confined to local space, which is screen coordinates
	# The Camera is moving in world space, centered on the players x,y
	# To the camera the starting position is (0,0)
	#TODO: Maybe wont work if foreground map is missing some tiles if nothings on top of background
	# var mousePosition = custom_tile_map.background_map.world_to_map(get_global_mouse_position())
	# grid_lines.process_update(delta)
	# grid_lines_hover.process_update(delta)
	# player.process_update(delta)
	# camera.process_update(delta)
	
#	if grid_lines_hover.cursor_path:
#		animate_movement(delta)
	pass

func reflect_vector(vector: Vector2):
	return Vector2(vector.y, vector.x)

# Returns x,y
func get_player_cell() -> Vector2:
	var player_cell = custom_tile_map.background_map.world_to_map(player.position)
	player_cell = reflect_vector(player_cell)
	return player_cell

# Accepts a row, col, returns an x,y
func set_player_cell(destination: Vector2):
	destination = reflect_vector(destination) * common.tile_size
	player.global_position = destination

func start_animation():
	# Need to generate points on curve from current position to new position
	# TODO: Maybe subtract each point by global position
	var offset: Vector2 = Vector2.ONE * common.tile_size / 2
	follow.global_position = grid_lines_hover.cursor_path[-1] - offset
	reset_path(true, false)
	for i in range(len(grid_lines_hover.cursor_path) -1, -1, -1):
		var point = grid_lines_hover.cursor_path[i] - offset
		curve.add_point(point)
	follow.offset = 0
	follow.unit_offset = 0.0
	follow.loop = false

func reset_path(clear_follow: bool = true, reset_player: bool = true):
	var new_pos = follow.global_position
	curve.clear_points()
	
	for child_node in follow.get_children():
		follow.remove_child(child_node)
	
	if clear_follow:
		# Need to put player back in battle scene and not under path follow
		remove_child(player)
		follow.add_child(player)
	
	if reset_player:
		add_child(player)
	
	player.global_position = new_pos

func animate_movement(delta: float):
	if curve.get_point_count() <= 0:
		return
	
	follow.offset += path_follow_speed * delta
	player.rotation_degrees = -follow.rotation_degrees
	
	if follow.unit_offset == 1 or curve.get_point_count() == 1:
		player.rotation_degrees = 0
		reset_path(false, true)
		grid_lines_hover.animating_player = false
		emit_signal("movement_ended")
