class_name MainMenuState extends State

func _ready():
	set_name("MainMenuState")
	var main_menu_scene: MainMenuScene = preload("res://interfaces/main_menu/main_menu.tscn").instance()
	add_local_scene(main_menu_scene)
	local_scene.begin_battle_button.connect("pressed", self, "begin_battle_pressed")
	local_scene.exit_game_button.connect("pressed", self, "exit_game_pressed")

func begin_battle_pressed():
	get_node("/root/main").fsm_stack.transition_to(InBattleFSM.new())

func exit_game_pressed():
	get_tree().quit()
