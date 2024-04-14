extends Node

@export var enermy_speed_increase := 50.0
@export var max_enermy_speed := 500.0
@export var min_spawn_speed := 0.8
@export var respawn_delay := 1.5
@export var respawn_delay_decrease := 0.1

var loaded_scenes : Array = []
var scene = null
var spawn_gap = 110
var enermy_speed = 200

@onready var enermy = preload("res://Scenes/Enermy.tscn")
@onready var Loader : Area2D = $Loader
@onready var LevelEnvironment : Node2D = $"../Environment"
@onready var Player : CharacterBody2D = $"../Player"
@onready var Counter : Timer = $Timer
@onready var ScoreCounter : Label = $"../Camera/Control/HUD/Score"
@onready var scene_assets : Array = [
	preload("res://Scenes/Prefabs/Fab_01.tscn"),
	preload("res://Scenes/Prefabs/Fab_02.tscn"),
	preload("res://Scenes/Prefabs/Fab_03.tscn")
]


func _process(_delta):
	ScoreCounter.text = str(floor((Player.position.x + 840) / 20))
	Counter.wait_time = respawn_delay


func _on_loader_body_entered(body):
	if body.is_in_group("player"):
		if enermy_speed < max_enermy_speed:
			enermy_speed += enermy_speed_increase

		if respawn_delay < min_spawn_speed:
			respawn_delay -= 0.1

		scene = scene_assets[randi() % len(scene_assets)].instantiate()
		loaded_scenes.append(scene)

		Loader.position.x += 1920
		scene.position.y = 328
		scene.position.x = Loader.get_position().x + 2760

		LevelEnvironment.add_child(scene)

		if len(loaded_scenes) > 4:
			loaded_scenes[0].queue_free()
			loaded_scenes.pop_at(0)


func _on_timer_timeout():
	for i in randi_range(3, 5):
		var e = enermy.instantiate()
		e.position.y = randi_range(-1, 6) * spawn_gap
		e.position.x = Player.position.x + 2000
		e.speed = enermy_speed
		add_child(e)
