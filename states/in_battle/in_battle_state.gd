class_name InBattleState extends State

func _init():
	.set_name("InBattleState")
	var in_battle_scene: InBattleScene = preload("res://scenes/in_battle/in_battle.tscn").instance()
	self.state_scene = in_battle_scene

func _ready():
	self.add_child(self.state_scene)

func update_state(delta: float):
	self.state_scene.update_scene()
