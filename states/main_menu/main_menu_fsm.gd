class_name MainMenuFSM extends StateMachine

func _ready():
	set_name("MainMenuFSM")
	add_state(MainMenuState.new())
