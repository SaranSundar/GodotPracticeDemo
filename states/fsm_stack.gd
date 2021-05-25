class_name FSM_Stack extends Node

# This is a mix of pushdown automaton and hierarchal finite state machine

var state_machines: Array = []

# Only getter method established
# You have to use object reference with self. for getters and setters
var state_machine: StateMachine = null setget set_state_machine, get_state_machine

func set_state_machine(_value):
	# Should not Be able to set the state, since it's just calculated from the top of the stack
	# _value will be unused
   return

func get_state_machine():
	return state_machines.front()

func free_state_machine():
	var copy = self.state_machine
	remove_child(self.state_machine)
	return copy
	
func add_state_machine(new_state_machine: StateMachine):
	self.state_machines.push_front(new_state_machine)
	# TODO: needs to actually use code that switches scenes, theres a scene transition example online
	add_child(self.state_machine)

func remove_state_machine():
	var copy = free_state_machine()
	# Clean up resources
	copy.cleanup_fsm()
	# TODO: Not sure if this is a bug or not to free state before popping it
	self.state_machines.pop_front()
	# TODO: This will have a bug if the previous state was freed
	add_child(self.state_machine)


func _init() -> void:
	set_name("FSM_Stack")

func handle_input(event: InputEvent) -> void:
	self.state_machine.handle_input(event)


func update_state_machine(delta: float) -> void:
	self.state_machine.update_state_machine(delta)


func physics_update_state_machine(delta: float) -> void:
	self.state_machine.physics_update_state_machine(delta)


# Will have the keys from TransitionOptions
# Will either transition to new state by adding new state,
# or transition to old state by exiting and popping of current state
func transition_to(transition_state_machine: StateMachine) -> void:
	if transition_state_machine != null:
		# Will first remove current fsm from scene tree, then add new fsm
		free_state_machine()
		add_state_machine(transition_state_machine)
	else:
		remove_state_machine()
