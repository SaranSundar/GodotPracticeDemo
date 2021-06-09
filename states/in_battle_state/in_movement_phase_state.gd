class_name InMovementPhaseState extends State

var grid_utils: GridUtils = GridUtils.new()
var common: Common = preload("res://resources/common/common_resource.tres")

var in_battle_scene: InBattleScene

var movement_range: int = 4
var tile_map_grid: Array

var starting_cell: Vector2 = Vector2(1, 2)

var bfs: Dictionary

signal exit_battle_state

# When this state starts a player is selected for movement,
# so it should show the bfs of available movement tiles
# Then as you use cursor over tile it should show path

func _ready():
	set_name("InMovementPhaseState")
	in_battle_scene = state_machine.global_scene
	# This state is called for each player controlled character
	tile_map_grid = in_battle_scene.grid_lines.current_level
	in_battle_scene.connect("movement_ended", self, "movement_ended")

func enter(data := {}) -> void:
	in_battle_scene.set_player_cell(starting_cell)
	bfs = grid_utils.search_for_tiles(in_battle_scene.get_player_cell(), movement_range)
	in_battle_scene.grid_lines_hover.bfs = bfs

func movement_ended():
	state_machine.transition_to(InAttackPhaseState.new())

# Virtual function. Corresponds to the `_process()` callback.
func process_update(delta: float) -> void:
	in_battle_scene.grid_lines.process_update(delta)
	in_battle_scene.grid_lines_hover.process_update(delta)
	in_battle_scene.player.process_update(delta)
	in_battle_scene.camera.process_update(delta)
	
	if in_battle_scene.grid_lines_hover.cursor_path:
		in_battle_scene.animate_movement(delta)

func process_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# Escape back to main menu fsm
		emit_signal("exit_battle_state")
		
