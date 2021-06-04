class_name InMovementPhaseState extends State

var grid_utils: GridUtils
var common: Common = preload("res://resources/common/common_resource.tres")

var in_battle_scene: InBattleScene

var starting_cell = Vector2(0, 0)
var movement_range: int = 4
var tile_map_grid: Array

# When this state starts a player is selected for movement,
# so it should show the bfs of available movement tiles
# Then as you use cursor over tile it should show path

func _ready():
	set_name("InMovementPhaseState")
	grid_utils = GridUtils.new()
	in_battle_scene = state_machine.global_scene
	# This state is called for each player controlled character
	tile_map_grid = in_battle_scene.grid_lines.current_level
	var bfs = grid_utils.search_for_tiles(starting_cell, movement_range)
	in_battle_scene.grid_lines.bfs = bfs
	in_battle_scene.grid_lines_hover.bfs = bfs

# Virtual function. Corresponds to the `_process()` callback.
func process_update(delta: float) -> void:
	in_battle_scene.grid_lines.process_update(delta)
	in_battle_scene.grid_lines_hover.process_update(delta)
	in_battle_scene.player.process_update(delta)
	in_battle_scene.camera.process_update(delta)
