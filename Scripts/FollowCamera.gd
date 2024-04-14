extends Camera2D

@onready var Player : CharacterBody2D = $"../Player"


func _process(_delta):
	position.x = lerp(position.x, Player.position.x, 0.2)
