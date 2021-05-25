class_name StateMachine extends Node

# This is a mix of pushdown automaton and hierarchal finite state machine

var states: Array = []

enum {
	TRANSITION_STATE
}

# Only getter method established
# You have to use object reference with self. for getters and setters
var state: State = null setget set_state, get_state

# --- These 2 variables below are meant to be overriden in each class that extends this one
var transition_func_ref = funcref(self, "transition_to")
# Each fsm holds a high level container scene that the states interact with
var container_scene = null

func set_state(_value):
	# Should not Be able to set the state, since it's just calculated from the top of the stack
	# _value will be unused
   return

func get_state():
	return states.front()

func free_state():
	var copy = self.state
	remove_child(self.state)
	copy.exit()
	
func add_state(new_state: State, data: Dictionary = {}):
	new_state.transition_to = transition_func_ref
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


func _init() -> void:
	set_name("StateMachine")
	# Extend this class and override this method, Initialize first state here and add it to states stack

func handle_input(event: InputEvent) -> void:
	self.state.handle_input(event)


func update_state_machine(delta: float) -> void:
	self.state.update_state(delta)


func physics_update_state_machine(delta: float) -> void:
	self.state.physics_update_state(delta)

func add_container_scene(new_container_scene):
	if is_instance_valid(self.container_scene):
		remove_child(self.container_scene)
		self.container_scene.queue_free()
	self.container_scene = new_container_scene
	add_child(self.container_scene)

func cleanup_fsm():
	# Do any cleanup logic here to delete all states
	remove_child(self.container_scene)
	self.container_scene.queue_free()
	queue_free()


# Will have the keys from TransitionOptions
# Will either transition to new state by adding new state,
# or transition to old state by exiting and popping of current state
func transition_to(data: Dictionary = {}) -> void:
	var transition_state = data[TRANSITION_STATE]
	if transition_state != null:
		# We have a state to transition to
		add_state(transition_state, data)
	else:
		# We want to pop of current state
		free_state()

# Will return new instance of state based on state name
# Will only be called when adding new state, or adding a state that was queue freed
func get_transition(transition_name):
	pass
