extends TileMap

# class member variables go here, for example:
var tile_size = get_cell_size()
var grid_size = Vector2(9, 9)
var grid = []
# The map_to_world function returns the position of the tile's top left corner in isometric space,
# we have to offset the objects on the Y axis to center them on the tiles
var tile_offset = Vector2(0, tile_size.y / 2)

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
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	print(get_used_cells())
