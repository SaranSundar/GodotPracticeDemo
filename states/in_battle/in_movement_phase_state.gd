class_name InMovementPhaseState extends State

var in_battle_scene: InBattleScene

func _ready():
	set_name("InMovementPhaseState")
	in_battle_scene = state_machine.global_scene
