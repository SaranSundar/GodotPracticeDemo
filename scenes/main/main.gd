class_name Main extends Node2D

# Mouse/Cursor Scene
onready var cursor = $cursor

var state_machine: StateMachine = null

func _init():
	state_machine = preload("res://states/main_menu/main_menu_fsm.gd").new()

func _ready():
	add_menu_fsm()

func add_menu_fsm():
	add_child(state_machine)

# The state machine subscribes to node callbacks and delegates them to the state machine objects.
func _unhandled_input(event: InputEvent) -> void:
	state_machine.handle_input(event)


func _process(delta: float) -> void:
	state_machine.update_state_machine(delta)


func _physics_process(delta: float) -> void:
	state_machine.physics_update_state_machine(delta)


# The scale of items on the map are the wrong size, need different tiles for that
#

# Some scenes need to be shared across multiple states such as combat,
# Some scenes need to transition with every state such as main menu to in battle

# Flow of battle
# 1. Battle Preperation
#	- Unit Placement
#	- Encampment
#	- Inventory
#	- Tutorials
#	- System
#	- Begin Battle

# 2. Battle Begins
#	- Explains objectives with dialogue boxes
#	- Shows the order of all unit movements at bottom of screen
#	- Selects Party member based on turn order, cannot be deselected
#	- For selected member, Shows blue and red movement squares
#	- A blue square is a safe spot to move, red will show who can attack there
#	- Option buttons each turn, A, X, and Y, B
#	- A is confirm, X is end turn, Y is details, B cancels last UI screen, if none focuses camera on character again
#	- Each tile you hover over will show tile stats on top right
#	- When you hover over other characters it will show there movement range, and quick stats such as health bar and level and current status
#	- As you move mouse over blue or red tiles, it will show path drawn from start to end
#	- You can press A to confirm on tile and go to attack sequence, or X to end turn on tile and choose facing direction
#	- In attack sequence, you can choose an action such as attack or use an item
#	- For each action it will show red tiles for range of action while player has blue hovering animation in new spot
#	- If an action is selected, choose the valid tile to perform action on
#	- If action is chosen on valid tile, move to tile if new tile was selection and perform action on tile selection for action.
#	- Note: Movement tile and action tile can differ
#	- Sometimes you can perform multiple actions, in this case the only way to end turn if no action is chosen is with X
#	- When you select end turn, choose direction to face and it will end the turn
#	- After you move the enemy will move, and dialogue sequences can be triggered in between player and enemy moves 
#	- For each action it will show detailed states about the action or item and the remaining uses
#	- Each turn the player will gain a charge, this charge can be stored to unleash stronger attacks
#	- ALTERNATIVELY: Consider other battle systems such as mana, starting with full charge, carrying charge across battles
