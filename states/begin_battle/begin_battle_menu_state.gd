class_name BeginBattleMenuState extends State

const begin_battle_menu_scene = preload("res://interfaces/begin_battle_menu/begin_battle_menu.tscn")
var begin_battle_menu

const in_battle_state = preload("res://states/in_battle/in_battle_state.gd")

var switch_scene = false

func _init():
	set_name("BeginBattleMenuState")
	begin_battle_menu = begin_battle_menu_scene.instance()
	add_child(begin_battle_menu)
	# Define exit transition to next state
	# This would enter the battle container with dialogue starting
	# If we never create new object for this referece, exiting to menu is more like pausing the game
	self.exit_state = in_battle_state.new()
	begin_battle_menu.connect("begin_battle", self, "begin_battle")

func begin_battle():
	print("Begin the battle")
	switch_scene = true

# Virtual function. Corresponds to the `_process()` callback.
func update(delta: float, transition_to: FuncRef) -> void:
	# When the begin battle button is pressed on the menu, it will transition in the state machine
	if switch_scene:
		switch_scene = false
		self.exit_state.queue_free()
		self.exit_state = null
		self.exit_state = in_battle_state.new()
		transition_to.call_func()

