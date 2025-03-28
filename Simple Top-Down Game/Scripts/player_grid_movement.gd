extends CharacterBody2D

var tileMap
var tileSize = Vector2(0,0)
var lastDir = 0
var toMove=Vector2(0,0)
var cam
var sprite

func _ready():
	cam = get_tree().get_first_node_in_group("player_camera")
	sprite = get_tree().get_first_node_in_group("player_sprite")
	tileMap = get_tree().get_first_node_in_group("tilemap") 
	tileSize = Vector2(tileMap.tile_set.tile_size)
	
	position = ((position/tileSize).round()*tileSize)+(tileSize/2)
	cam.position=position

func _process(_delta):
	#   movement script
	var directionX = Input.get_axis("Player_Left","Player_Right")
	var directionY = Input.get_axis("Player_Up","Player_Down")
	
	if Input.is_action_just_released("Player_Up"):
		lastDir=0
	if Input.is_action_just_released("Player_Right"):
		lastDir=1
	if Input.is_action_just_released("Player_Down"):
		lastDir=2
	if Input.is_action_just_released("Player_Left"):
		lastDir=3
	
	if directionX!=null && toMove.x==0:
		if lastDir==1 or lastDir==3:
			toMove.x+=(tileSize.x)*directionX
	if directionY!=null && toMove.y==0:
		if lastDir==0 or lastDir==2:
			toMove.y+=(tileSize.y)*directionY

func _on_timer_timeout():
	if toMove==Vector2(0,0):
		sprite.stop()
	else:
		position+=toMove
		cam.position=position
		
		#animation
		if toMove.x>0:
			sprite.play("right")
		elif toMove.x<0:
			sprite.play("left")
		elif toMove.y>0:
			sprite.play("down")
		elif toMove.y<0:
			sprite.play("up")
		
		toMove=Vector2(0,0)
