class_name MainMenuState extends State

func _init():
	.set_name("MainMenuState")
	var main_menu_scene: MainMenuScene = preload("res://interfaces/main_menu/main_menu.tscn").instance()
	self.state_scene = main_menu_scene

func _ready():
	self.add_child(self.state_scene)
	self.state_scene.begin_battle_button.connect("pressed", self, "begin_battle_pressed")
	self.state_scene.exit_game_button.connect("pressed", self, "exit_game_pressed")

func begin_battle_pressed():
	emit_signal("begin_battle")

func exit_game_pressed():
	get_tree().quit()
