extends Node

@export var pathfollow_ball_scene: PackedScene
@onready var path_2d: Path2D = $Path2D
var array_follows := []

func _ready() -> void:
	#create_ball()
	pass

func create_ball():
	var ball = pathfollow_ball_scene.instantiate()
	ball.id = array_follows.size() + 1
	path_2d.add_child(ball)
	array_follows.append({
		"id": ball.id,
		"ball": ball,
		"color": ball.get_color()
	})

func add_ball_to_path2D(ball_ref, new_ball):
	#print(ball_ref.id)
	#print(new_ball)
	new_ball.id = ball_ref.id
	
	for item in array_follows:
		if item.id < ball_ref.id:
			item.ball.progress_ratio += 0.01
		else:
			item.id += 1
			item.ball.id = item.id
	
	var new_ball_object = {
		"id": new_ball.id,
		"ball": new_ball,
		"color": new_ball.get_color()
	}
	array_follows.append(new_ball_object)
	
	var array_equals_color = []
	array_equals_color.append(new_ball_object)
	
	var array_find = []
	for i in range((new_ball.id - 1), 0, -1):
		array_follows.filter(func (x):
			if x.id == i:
				array_find.append(x)
		)
	for item in array_find:
		if item.color == new_ball.get_color():
			array_equals_color.append(item)
		else: break
	
	array_find = []
	for i in range(new_ball.id + 1, array_follows.size(), 1):
		array_follows.filter(func (x):
			if x.id == i:
				array_find.append(x)
		)
	for item in array_find:
		if item.color == new_ball.get_color():
			array_equals_color.append(item)
		else: break
	
	if array_equals_color.size() >= 3:
		for item in array_equals_color:
			array_follows.erase(item)
			path_2d.remove_child(item.ball)
			# TODO: falta cambiar los ids, ya que se eliminaros algunos, para mantener la coincistencia
	
	
	
func _on_timer_create_ball_timeout() -> void:
	create_ball()
