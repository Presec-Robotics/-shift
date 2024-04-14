extends Control


# Start screen
@onready var Ranking : Node = $"../../../GameManager/Ranking"

@onready var ErrorLabel : Label = $vbox/Label
@onready var UsernameInput : TextEdit = $vbox/Username
@onready var CreateBtn : BaseButton = $vbox/hbox/Create
@onready var OverwriteBtn : BaseButton = $vbox/hbox/Overwrite

var level = preload("res://Scenes/Level.tscn").instantiate()

func load_lavel():
	get_tree().root.add_child(level)

func _ready():
	Engine.time_scale = 0

func _on_create_pressed():
	if !Ranking.add_player(UsernameInput.text):
		ErrorLabel.visible = true
	else:
		load_lavel()
		visible = false
		Engine.time_scale = 1


func _on_overwrite_pressed():
	visible = false
	Ranking.explicit_add_player(UsernameInput.text)
	Engine.time_scale = 1
	load_lavel()
