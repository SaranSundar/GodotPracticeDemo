class_name InBattleState extends State

const battle_state_container_scene = preload("res://scenes/battle_state_container/battle_state_container.tscn")
var battle_state_container

const show_dialogue_state = preload("res://states/in_battle/show_dialogue_state.gd")

var show_dialogue = true

func _init():
	set_name("InBattleState")
	battle_state_container = battle_state_container_scene.instance()
	add_child(battle_state_container)
	self.exit_state = show_dialogue_state.new()

# Virtual function. Corresponds to the `_process()` callback.
func update(delta: float, transition_to: FuncRef) -> void:
	if show_dialogue:
		show_dialogue = false
		# Create new instance of exit state to reset it
		self.exit_state.queue_free()
		self.exit_state = null
		self.exit_state = show_dialogue_state.new()
		transition_to.call_func({'should_keep': true})
