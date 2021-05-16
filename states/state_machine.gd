class_name StateMachine extends Node

onready var states: Array = []

const first_state = preload("res://states/begin_battle/begin_battle_menu_state.gd")

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
	if self.state != null:
		# We can't call this here because this removes the base state
		# self.state.queue_free()
		remove_child(self.state)
	
func add_state(new_state: State, data: Dictionary = {}):
	if 'should_keep' in data and data['should_keep']:
		pass
	else:
		free_state()
	states.push_front(new_state)
	# TODO: Needs to call queue_free on the node for it to delete itself
	# TODO: needs to actually use code that switches scenes, theres a scene transition example online
	add_child(self.state)
	self.state.enter(data)

func remove_state():
	free_state()
	states.pop_front()
	# TODO: Needs to call queue_free on the node for it to delete itself
	add_child(self.state)


func _ready() -> void:
	set_name("StateMachine")
	# Initialize first state here and add it to states stack
	add_state(first_state.new())


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	self.state.handle_input(event, transition_func_ref)


func _process(delta: float) -> void:
	self.state.update(delta, transition_func_ref)


func _physics_process(delta: float) -> void:
	self.state.physics_update(delta)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `data` dictionary to pass to the next state's enter() function.
func transition_to(data: Dictionary = {}) -> void:
	var new_state = self.state.exit()
	if new_state == null:
		# If state has no new state to transition to, then pop stack to previous state
		remove_state()
	else:
		# Push new state 
		add_state(new_state, data)
