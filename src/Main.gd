extends Node2D

# class member variables go here, for example:
const START_BASE_TILE = "StartBase"

onready var Player = preload("res://src/Player.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Board/TileMap.position = Vector2(0, -get_viewport_rect().size.y / 2) # it's centering the board in screen.
	start_game()

func start_game():
  var player1 = Player.instance()
  var startTile = $Board/TileMap.get_start_tile_pos()
  var worldPos = $Board/TileMap.get_world_pos($Board/TileMap.move_to(startTile, 36))
  player1.set_position(worldPos)
  $Board/TileMap.add_child(player1)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
