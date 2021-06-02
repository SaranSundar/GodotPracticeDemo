class_name InMovementPhaseState extends State

var grid_utils: GridUtils
var common: Common = preload("res://resources/common/common_resource.tres")

var in_battle_scene: InBattleScene

var starting_cell = Vector2(0, 0)
var movement_range: int = 4
var tile_map_grid: Array

func _ready():
	set_name("InMovementPhaseState")
	grid_utils = GridUtils.new()
	in_battle_scene = state_machine.global_scene
	# This state is called for each player controlled character
	tile_map_grid = in_battle_scene.grid_lines.current_level
	var bfs = grid_utils.search_for_tiles(starting_cell, movement_range)
	in_battle_scene.grid_lines.update_bfs(bfs)
	move_player()
	

func move_player():
	var new_position = starting_cell + (Vector2.RIGHT * 2)
	var input_vector = new_position - global_position
	var points = [Vector2.ZERO, input_vector * common.tile_size]
	in_battle_scene.start_animation(points)

# Virtual function. Corresponds to the `_process()` callback.
func process_update(delta: float) -> void:
	in_battle_scene.animate_movement(delta)
