class_name MainMenuFSM extends StateMachine

enum STATE_TRANSITIONS {
	MAIN_MENU_SCENE
}

func _ready():
	.set_name("MainMenuFSM")
	# new_state: State, transition_func_ref: FuncRef, container_scene, data: Dictionary = {}
	self.add_state(get_transition(STATE_TRANSITIONS.MAIN_MENU_SCENE))

func get_transition(transition_name):
	match transition_name:
		STATE_TRANSITIONS.MAIN_MENU_SCENE:
			return preload("res://states/main_menu/main_menu_state.gd").new()
