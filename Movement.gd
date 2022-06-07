extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

var up = false
var down = false
var left = false
var right = false

var frame = 0
var frame_delta = 0

onready var sp = get_node( "Sprite" )

func get_input():
	if Input.is_action_pressed("right"):
		right = true
	else:
		right = false
	if Input.is_action_pressed("left"):
		left = true
	else:
		left = false
	if Input.is_action_pressed("down"):
		down = true
	else:
		down = false
	if Input.is_action_pressed("up"):
		up = true
	else:
		up = false
	if Input.is_action_pressed("run"):
		speed = 400
	else:
		speed = 200
		
func get_velocity():
	if right and !left:
		velocity.x = 1
	elif !right and left:
		velocity.x = -1	
	else:
		velocity.x = 0
	if up and !down:
		velocity.y = -1
	elif !up and down:
		velocity.y = 1
	else:
		velocity.y = 0

func get_frame():
	if velocity.x == 1:
		frame = 5
		sp.set_flip_h( false )
	elif velocity.x == -1:
		frame = 5
		sp.set_flip_h( true )
	elif velocity.y == 1:
		frame = 1
		sp.set_flip_h( false )
	elif velocity.y == -1:
		frame = 3
		sp.set_flip_h( false )
	else:
		if frame == 5 or frame == 6:
			frame = 8
		elif frame == 1 or frame == 2:
			frame = 0
		elif frame == 3 or frame == 4:
			frame = 7
		frame_delta = 0
	
	if speed == 200:	
		frame_delta+=1
	else:
		frame_delta+=2
	if frame_delta>=60:
		frame_delta=0

func _physics_process(delta):
	get_input()
	get_velocity()
	get_frame()
	
	sp.set_frame(frame+frame_delta/30)
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
