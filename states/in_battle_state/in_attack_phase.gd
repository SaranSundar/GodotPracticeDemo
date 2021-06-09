class_name InAttackPhaseState extends State

var grid_utils: GridUtils = GridUtils.new()
var common: Common = preload("res://resources/common/common_resource.tres")

var in_battle_scene: InBattleScene

var movement_range: int = 4
var tile_map_grid: Array

# When this state starts a player is selected for movement,
# so it should show the bfs of available movement tiles
# Then as you use cursor over tile it should show path

func _ready():
	set_name("InAttackPhaseState")
	in_battle_scene = state_machine.global_scene
	# This state is called for each player controlled character
	tile_map_grid = in_battle_scene.grid_lines.current_level

func enter(data := {}) -> void:
	#TODO: Clear grid and change it to show attack range
	in_battle_scene.grid_lines_hover.bfs = {}


# Virtual function. Corresponds to the `_process()` callback.
func process_update(delta: float) -> void:
	in_battle_scene.camera.process_update(delta)

func process_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# Escape back to movement phase
		state_machine.transition_to(null)