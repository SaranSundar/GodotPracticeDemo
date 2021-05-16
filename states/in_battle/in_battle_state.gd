class_name InBattleState extends State

const battle_state_container_scene = preload("res://scenes/battle_state_container/battle_state_container.tscn")
var battle_state_container

func _init():
	set_name("InBattleState")
	battle_state_container = battle_state_container_scene.instance()
	add_child(battle_state_container)

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(event: InputEvent, transition_to: FuncRef) -> void:
	if event.is_action("ui_cancel"):
		transition_to.call_func()
