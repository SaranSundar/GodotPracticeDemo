class_name StateMachine extends Node

# This is a mix of pushdown automaton and hierarchal finite state machine

onready var states: Array = []

# Each fsm holds a high level container scene that the states interact with
var vont: Node2D

enum TransitionOptions {
	# (String) Target state to transition to, if exit will just pop state of stack and queue free it
	TRANSITION_STATE,
	# True/False, if true will make new instance of transition even when just resuming previous state from popping off current
	CREATE_NEW_TRANSITION,
	# True/False If true will signal to parent to clean up fsm
	EXIT_STATE_MACHINE
}

# Only getter method established
# You have to use object reference with self. for getters and setters
var state: State = null setget set_state, get_state

var transition_func_ref = funcref(self, "transition_to")

func set_state(_value):
	# Should not Be able to set the state, since it's just calculated from the top of the stack
	# _value will be unused
   return

func get_state():
	return states.front()

func free_state():
	var copy = self.state
	remove_child(self.state)
	copy.queue_free()
	
func add_state(new_state: State, data: Dictionary = {}):
	if 'should_keep' in data and data['should_keep']:
		pass
	else:
		free_state()
	states.push_front(new_state)
	# TODO: needs to actually use code that switches scenes, theres a scene transition example online
	add_child(self.state)
	self.state.enter(data)

func remove_state():
	free_state()
	# TODO: Not sure if this is a bug or not to free state before popping it
	states.pop_front()
	# TODO: This will have a bug if the previous state was freed
	add_child(self.state)


func _ready() -> void:
	set_name("StateMachine")
	# Extend this class and override this method, Initialize first state here and add it to states stack


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	self.state.handle_input(event, transition_func_ref)


func _process(delta: float) -> void:
	self.state.update(delta, transition_func_ref)


func _physics_process(delta: float) -> void:
	self.state.physics_update(delta)


# Override this method to define all possible states in the fsm
# The data dictionary will have a key for the state to transition to
# It will also have a key to say whether to preserve its state or to free it
# It will also have a key whether to try and find preserved state for transition state or to create a new one
func transition_to(data: Dictionary = {}) -> void:
	pass

# Will return new instance of state based on state name
func get_transition(transition_name):
	pass
