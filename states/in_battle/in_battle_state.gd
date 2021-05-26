class_name InBattleState extends State

func _ready():
	set_name("InBattleState")
	transition_to(DialogueState.new(), false)


func process_update(delta: float):
	state_machine.container_scene.process_update(delta)

func process_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# Escape back to menu fsm
		get_node("/root/main").fsm_stack.transition_to(null)
