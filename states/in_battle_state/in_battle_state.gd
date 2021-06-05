class_name InBattleState extends State

var battle_fsm: StateMachine

func _ready():
	set_name("InBattleState")
	#Battle FSM
	battle_fsm = StateMachine.new()
	battle_fsm.set_name("BattleStateMachine")
	add_child(battle_fsm)
	var in_battle_scene: InBattleScene = preload("res://scenes/in_battle/in_battle.tscn").instance()
	battle_fsm.add_global_scene(in_battle_scene)
	# Start dialog at beginning of battle state
	var movement_phase = InMovementPhaseState.new()
	movement_phase.connect("exit_battle_state", self, "exit_battle_fsm")
	battle_fsm.transition_to(movement_phase)
	battle_fsm.transition_to(DialogueState.new())


# Virtual function. Receives events from the `_unhandled_input()` callback.
func process_input(event: InputEvent) -> void:
	battle_fsm.process_input(event)

 
func process_update(delta: float):
	if battle_fsm.state.name == "InMovementPhaseState":
		battle_fsm.global_scene.grid_lines_hover.is_active_state = true
	else:
		battle_fsm.global_scene.grid_lines_hover.is_active_state = false
		
	battle_fsm.global_scene.process_update(delta)
	battle_fsm.process_update(delta)

func exit_battle_fsm():
	# Escape back to main menu fsm
	battle_fsm.exit()
	state_machine.transition_to(null)
		
