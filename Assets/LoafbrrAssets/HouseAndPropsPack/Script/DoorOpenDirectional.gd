extends Node3D

@onready var animation = $AnimationPlayer

enum { CLOSED, CLOSING, OPENING, OPEN }
var door_state = CLOSED
var in_outside_area = false
var in_inside_area = false
var closing_animation = ""

func check_door_state():
	match door_state:
		CLOSED:
			if in_outside_area:
				door_state = OPENING
				animation.play("open_inward")
				closing_animation = "open_inward"
			elif in_inside_area:
				door_state = OPENING
				animation.play("open_outward")
				closing_animation = "open_outward"
		OPENING:
			pass
		CLOSING:
			pass
		OPEN:
			if !in_outside_area and !in_inside_area:
				door_state = CLOSING
				animation.play_backwards(closing_animation)

func _on_animation_player_animation_finished(anim_name):
	match door_state:
		OPENING:
			door_state = OPEN
		CLOSING:
			door_state = CLOSED
	check_door_state()

func _on_outside_area_3d_body_entered(body):
	if body is CharacterBody3D:
		in_outside_area = true
		check_door_state()

func _on_outside_area_3d_body_exited(body):
	if body is CharacterBody3D:
		in_outside_area = false
		check_door_state()

func _on_inside_area_3d_body_entered(body):
	if body is CharacterBody3D:
		in_inside_area = true
		check_door_state()
		
func _on_inside_area_3d_body_exited(body):
	if body is CharacterBody3D:
		in_inside_area = false
		check_door_state()
