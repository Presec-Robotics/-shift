extends CharacterBody2D

var speed : float = 400.0
var is_alive = true

@onready var GameOverText : Label = $"../Camera/Control/HUD/GameOver"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_alive:
		position.y = event.position.y


func _physics_process(_delta) -> void:
	velocity.x = speed
	velocity.y = 0
	
	move_and_slide()

	if Input.is_action_pressed("reset") and !is_alive:
		GameOverText.visible = false
		Engine.time_scale = 1
		is_alive = true
		get_tree().reload_current_scene()


func _on_hurt_box_body_entered(body):
	if body.is_in_group("enermy"):
		is_alive = false
		GameOverText.visible = true
		Engine.time_scale = 0
