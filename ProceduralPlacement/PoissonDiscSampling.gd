
# float radius
# Vector2 sampleRegionSize
# return : Array of valid positions (Vector2)
static func generate_points(radius, sample_region_size, num_samples_before_rejection = 30):
	var cell_size = radius / sqrt(2)
	var grid = create_2d_array(ceil(sample_region_size.x / cell_size), ceil(sample_region_size.y / cell_size), 0)
	var points = []
	var spawn_points = []
	
	spawn_points.append(sample_region_size / 2)
	while spawn_points.size() > 0:
		var spawn_index = randi() % spawn_points.size()
		var spawn_center = spawn_points[spawn_index]
		var candidate_accepted = false
		
		for i in range(num_samples_before_rejection):
			var angle = randf() * PI * 2
			var direction = Vector2(sin(angle), cos(angle))
			var candidate = spawn_center + direction * rand_range(radius, 2 * radius)
			# (candidate, sample_region_size, cell_size, radius, points, grid)
			if is_valid(candidate, sample_region_size, cell_size, radius, points, grid):
				points.append(candidate)
				spawn_points.append(candidate)
				grid[int(candidate.x / cell_size)][int(candidate.y / cell_size)] = points.size()
				candidate_accepted = true
				break
				
		if candidate_accepted != true:
			spawn_points.remove(spawn_index)
			
	return points
	
static func is_valid(candidate, sample_region_size, cell_size, radius, points, grid):
	if candidate.x >= 0 and candidate.x < sample_region_size.x and candidate.y >= 0 and candidate.y < sample_region_size.y:
		var cell_x = int(candidate.x / cell_size)
		var cell_y = int(candidate.y / cell_size)
		var search_start_x = max(0, cell_x - 2)
		var search_end_x = min(cell_x + 2, grid.size() - 1)
		var search_start_y = max(0, cell_y - 2)
		var search_end_y = min(cell_y + 2, grid[0].size() - 1)
		
		for x in range(search_start_x, search_end_x + 1):
			for y in range(search_start_y, search_end_y + 1):
				var point_index = grid[x][y] - 1
				if point_index != -1:
					var dist = (candidate - points[point_index]).length_squared()
					if dist < radius * radius:
						return false
					
				
		return true
	return false
	
static func create_2d_array(height, width, value):
	var arr = []
	for x in range(height):
		arr.append([])
		arr[x].resize(width)
		for y in range(width):
			arr[x][y] = 0
	return arr