class_name InBattleState extends State

var battle_fsm: StateMachine

func _ready():
	set_name("InBattleState")
	var in_battle_scene: InBattleScene = preload("res://scenes/in_battle/in_battle.tscn").instance()
	add_local_scene(in_battle_scene)
	
	#Battle FSM
	battle_fsm = StateMachine.new()
	battle_fsm.set_name("BattleStateMachine")
	add_child(battle_fsm)
	# Start dialog at beginning of battle state
	battle_fsm.transition_to(InMovementPhaseState.new())
	battle_fsm.transition_to(DialogueState.new())


func process_update(delta: float):
	local_scene.process_update(delta)
	battle_fsm.process_update(delta)

func process_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# Escape back to main menu fsm
		battle_fsm.exit()
		state_machine.transition_to(null)
