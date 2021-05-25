class_name InBattleState extends State

func _init():
	.set_name("InBattleState")


func update_state(delta: float):
	get_parent().container_scene.update_scene(delta)

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# Escape back to menu fsm
		get_node("/root/main").fsm_stack.transition_to(null)
