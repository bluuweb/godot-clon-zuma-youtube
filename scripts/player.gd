extends CharacterBody2D

@export var pathfollow_ball_scene: PackedScene

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			create_ball()

func get_input():
	# En Godot, la función look_at() hace que un nodo gire o apunte hacia una posición específica en el espacio. Esta función es comúnmente utilizada para que un personaje o un objeto mire hacia otro punto o hacia otro nodo en la escena.
	look_at(get_global_mouse_position())
	
func _physics_process(delta: float) -> void:
	get_input()

func create_ball():
	var direction_to_mouse = global_position.direction_to(get_global_mouse_position())
	var pathfollow_ball = pathfollow_ball_scene.instantiate()
	pathfollow_ball.create_ball_player(direction_to_mouse, global_position)
	get_parent().add_child(pathfollow_ball)
	
