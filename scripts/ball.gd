@tool
extends Area2D

@export var color:Color = "blue"
var radius = 20
var speed = 300
var direction_mouse
var direction_player
var is_player_ball = false
var path_follow_ref: PathFollow2D

func _ready() -> void:
	if is_player_ball:
		$SpriteBlue.visible = false
		$SpriteRed.visible = true

func _process(delta: float) -> void:
	if direction_mouse and is_player_ball:
		global_position += speed * delta * direction_mouse

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if path_follow_ref:
		print(path_follow_ref.progress_ratio)
		area.is_player_ball = false
		Global.on_ball_add_to_path.emit(area, path_follow_ref.progress_ratio)
		#area.queue_free()
	#if is_player_ball:
		
		
