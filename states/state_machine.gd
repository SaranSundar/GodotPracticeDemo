class_name StateMachine extends BaseEntity

# This is a mix of pushdown automaton and hierarchal finite state machine

# Sometimes a state machine may want to hold a scene that the states in the state machine
# can access. A good example of this is the in_battle_state where all of it's states
# need access to the in_battle_scene
var global_scene: BaseEntity = null

var states: Array = []

# Only getter method established
# You have to use object reference with self. for getters and setters
var state = null setget set_state, get_state

func set_state(_value):
	# Should not Be able to set the state, since it's just calculated from the top of the stack
	# _value will be unused
   return

func get_state():
	if self.states:
		return states.front()

func free_state():
	var copy = self.state
	if copy:
		remove_child(copy)
	return copy
	
func add_state(new_state, data: Dictionary = {}):
	new_state.state_machine = self
	states.push_front(new_state)
	# TODO: needs to actually use code that switches scenes, theres a scene transition example online
	add_child(self.state)
	self.state.enter(data)

func remove_state(data: Dictionary = {}):
	var copy = free_state()
	copy.exit()
	# TODO: Not sure if this is a bug or not to free state before popping it
	states.pop_front()
	# TODO: This will have a bug if the previous state was freed
	add_child(self.state)
	self.state.enter(data)


func _init() -> void:
	set_name("StateMachine")
	
# Virtual function. Receives events from the `_unhandled_input()` callback.
func process_input(event: InputEvent) -> void:
	if self.state:
		self.state.process_input(event)


# Virtual function. Corresponds to the `_process()` callback.
func process_update(delta: float) -> void:
	if self.state:
		self.state.process_update(delta)


# Virtual function. Corresponds to the `_physics_process()` callback.
func process_physics_update(delta: float) -> void:
	if self.state:
		self.state.process_physics_update(delta)

func add_global_scene(new_global_scene):
	if is_instance_valid(global_scene):
		remove_child(global_scene)
		global_scene.queue_free()
	global_scene = new_global_scene
	add_child(global_scene)

func exit():
	# Do any cleanup logic here to delete all states
	# TODO: go through each state in array and clean them up before exiting
	remove_child(global_scene)
	global_scene.queue_free()
	queue_free()


# Will have the keys from TransitionOptions
# Will either transition to new state by adding new state,
# or transition to old state by exiting and popping of current state
func transition_to(transition_state, data: Dictionary = {}) -> void:
	if transition_state != null:
		# Remove current state from scene tree before adding new one
		free_state()
		add_state(transition_state, data)
	else:
		# We want to pop of current state and call exit on it
		remove_state(data)
