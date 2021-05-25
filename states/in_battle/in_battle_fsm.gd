class_name InBattleFSM extends StateMachine

enum STATE_TRANSITIONS {
	IN_BATTLE_STATE,
	SHOW_DIALOGUE_STATE
}

func _ready():
	.set_name("InBattleFSM")
	# new_state: State, transition_func_ref: FuncRef, container_scene, data: Dictionary = {}
	var in_battle_scene: InBattleScene = preload("res://scenes/in_battle/in_battle.tscn").instance()
	self.add_container_scene(in_battle_scene)
	self.add_state(get_transition(STATE_TRANSITIONS.IN_BATTLE_STATE))

func get_transition(transition_name):
	match transition_name:
		STATE_TRANSITIONS.IN_BATTLE_STATE:
			return preload("res://states/in_battle/in_battle_state.gd").new()
		STATE_TRANSITIONS.SHOW_DIALOGUE_STATE:
			return preload("res://states/dialogue_state/dialogue_state.gd").new()
