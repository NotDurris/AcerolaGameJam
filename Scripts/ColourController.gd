@tool
extends Node

@export var light_mat : ShaderMaterial
@export var mid_mat : ShaderMaterial
@export var dark_mat : ShaderMaterial
@export var screen_mat : ShaderMaterial

@export var colour : Color :
	set(value):
		# I Know Mr.Rola
		var hsv_colour = rgb2hsv(value)
		hsv_colour.y = 1
		hsv_colour.z = 0.5
		colour = Color.from_hsv(hsv_colour.x, hsv_colour.y,hsv_colour.z)
		light_mat.set_shader_parameter("colour", Color.from_hsv(hsv_colour.x, hsv_colour.y,hsv_colour.z+0.2))
		mid_mat.set_shader_parameter("colour", colour)
		dark_mat.set_shader_parameter("colour", Color.from_hsv(hsv_colour.x, hsv_colour.y,hsv_colour.z-0.2))
		var complementary_colour = hsv_colour
		if complementary_colour.x > 0.5:
			complementary_colour.x -= 0.5
		else:
			complementary_colour.x += 0.5
		screen_mat.set_shader_parameter("background_colour", Color.from_hsv(complementary_colour.x, complementary_colour.y-0.6,complementary_colour.z-0.2))
		
		var complemen2ry_colour = hsv_colour
		complemen2ry_colour.x += (hsv_colour.x - complementary_colour.x) * 0.8
		
		screen_mat.set_shader_parameter("line_colour", Color.from_hsv(complemen2ry_colour.x, complemen2ry_colour.y-0.4,complemen2ry_colour.z))
		screen_mat.set_shader_parameter("background_line_colour", Color.from_hsv(complemen2ry_colour.x, complemen2ry_colour.y-0.4,complemen2ry_colour.z-0.4))

func rgb2hsv(rgb_colour : Color) -> Vector3:
	var r = rgb_colour.r
	var g = rgb_colour.g
	var b = rgb_colour.b
	var c_max = maxf(maxf(r,g),b)
	var c_min = minf(minf(r,g),b)
	var delta : float = c_max - c_min
	
	#Calculate Hue
	var H
	if delta == 0.0:
		H = 0.0
	elif c_max == r:
		H = ((g-b)/delta + 6)
	elif c_max == g:
		H = ((b-r)/delta + 2)
	elif c_max == b:
		H = ((r-g)/delta + 4)
	H = H/6
	#Calculate Saturation
	var S
	if c_max == 0:
		S = 0
	else:
		S = delta/c_max
	var V = c_max
	
	return Vector3(H,S,V)
