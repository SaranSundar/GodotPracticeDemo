class_name InBattleState extends State

func _init():
	.set_name("InBattleState")

func _ready():
	var data = {}
	data[self.state_machine.StateOptions.TRANSITION_STATE] = self.state_machine.get_transition(self.state_machine.STATE_TRANSITIONS.SHOW_DIALOGUE_STATE)
	data[self.state_machine.StateOptions.KEEP_STATE] = true
	self.state_machine.transition_to(data)


func update_state(delta: float):
	get_parent().container_scene.update_scene(delta)

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# Escape back to menu fsm
		get_node("/root/main").fsm_stack.transition_to(null)
