extends TileMap

# class member variables go here, for example:
var tile_size = get_cell_size()
var grid_size = Vector2(9, 9)
var grid = []
# The map_to_world function returns the position of the tile's top left corner in isometric space,
# we have to offset the objects on the Y axis to center them on the tiles
var tile_offset = Vector2(0, tile_size.y / 2)
var BOTTOM_LEFT_CORNER = Vector2(grid_size.x - 1, grid_size.y - 1)
var BOTTOM_RIGHT_CORNER = Vector2(grid_size.x - 1, 0)
var TOP_LEFT_CORNER = Vector2(0, grid_size.y - 1)
var TOP_RIGHT_CORNER = Vector2(0, 0)

const BASE_TILE = "Base"
const BASE2_TILE = "Base2"
const START_BASE_TILE = "StartBase"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var a = Vector2(x, y)
			var b = Vector2(y, x)
			if x == 0:
				set_cellv(a, self.tile_set.find_tile_by_name(BASE_TILE))
				set_cellv(b, self.tile_set.find_tile_by_name(BASE_TILE))
				grid[x][y] = a
				grid[y][x] = b
			elif x == 8:
				set_cellv(b, self.tile_set.find_tile_by_name(BASE_TILE))
				set_cellv(a, self.tile_set.find_tile_by_name(BASE_TILE))
				grid[x][y] = a
				grid[y][x] = b
	var startBasev = Vector2(grid_size.x - 1, grid_size.y - 1)
	set_cellv(startBasev, self.tile_set.find_tile_by_name(START_BASE_TILE))
	grid[grid_size.x - 1][grid_size.y - 1] = startBasev

func get_cell_content(pos = Vector2()):
	return grid[pos.x][pos.y]
	
func get_start_tile_pos():
	return get_cell_content(Vector2(grid_size.x - 1, grid_size.y - 1))

func get_world_pos(pos = Vector2()):
  return map_to_world(pos)

func move_to(pos = Vector2(), to = int()):
  var res = pos
  for i in range(to):
    res = _get_next_pos(res, 1)
  return res
  
func _get_next_pos(pos = Vector2(), to = int()):
  if is_corner(pos):
    if pos == TOP_LEFT_CORNER:
      return decrease_y_vec2(pos, to)
    elif pos == TOP_RIGHT_CORNER:
      return increment_x_vec2(pos, to)
    elif pos == BOTTOM_RIGHT_CORNER:
      return increment_y_vec2(pos, to)
    elif pos == BOTTOM_LEFT_CORNER:
      return decrease_x_vec2(pos, to)
  else:
    if pos.x == 0 && pos.y >= 0: #TOP
      return decrease_y_vec2(pos, to)
    elif pos.y == 0 && pos.x >= 0: #RIGHT
      return increment_x_vec2(pos, to)
    elif pos.x == grid_size.x - 1 && pos.y >=0: #BOTTOM
      return increment_y_vec2(pos, to)
    elif pos.y == grid_size.y - 1 && pos.x >= 0: #LEFT
      return decrease_x_vec2(pos, to)

func is_corner(pos = Vector2()):
  if pos == TOP_LEFT_CORNER:
    return true
  elif pos == TOP_RIGHT_CORNER:
    return true
  elif pos == BOTTOM_LEFT_CORNER:
    return true
  elif pos == BOTTOM_RIGHT_CORNER:
    return true
  else:
    return false
  
func increment_y_vec2(pos = Vector2(), num = int()):
  return Vector2(pos.x, pos.y + num)

func increment_x_vec2(pos = Vector2(), num = int()):
  return Vector2(pos.x + num, pos.y)

func decrease_x_vec2(pos = Vector2(), num = int()):
  return Vector2(pos.x - num, pos.y)

func decrease_y_vec2(pos = Vector2(), num = int()):
  return Vector2(pos.x, pos.y - num)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	print(get_used_cells())
