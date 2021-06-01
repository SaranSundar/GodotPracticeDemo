class_name InBattleScene extends BaseEntity

onready var custom_tile_map: CustomTileMap = $custom_tile_map
onready var player = $player
onready var camera = $camera
onready var grid_lines = $GridLines

func _ready():
	set_name("InBattleScene")
	connect_cursor_to_grid_lines()

func connect_cursor_to_grid_lines():
	var cursor: Cursor = get_node("/root/main/cursor")
	cursor.connect("cursor_moved", grid_lines, "cursor_move_received")
	cursor.connect("cursor_clicked", grid_lines, "cursor_click_received")

func process_update(delta: float):
	grid_lines.process_update(delta)
	player.process_update(delta)
	camera.process_update(delta)
