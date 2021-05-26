class_name InBattleFSM extends StateMachine

func _ready():
	set_name("InBattleFSM")
	# new_state: State, transition_func_ref: FuncRef, container_scene, data: Dictionary = {}
	var in_battle_scene: InBattleScene = preload("res://scenes/in_battle/in_battle.tscn").instance()
	add_container_scene(in_battle_scene)
	add_state(InBattleState.new())
