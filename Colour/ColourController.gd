extends Node

@onready var light_mat : ShaderMaterial = preload("res://Shaders/ObjectShader/Material/Bright.tres")
@onready var mid_mat : ShaderMaterial = preload("res://Shaders/ObjectShader/Material/Mid.tres")
@onready var dark_mat : ShaderMaterial = preload("res://Shaders/ObjectShader/Material/Dark.tres")
@onready var jaggy_mat : ShaderMaterial = preload("res://Shaders/ObjectShader/Material/Jaggy.tres")
@onready var screen_mat : ShaderMaterial = preload("res://Shaders/ScreenShader/screen_shader.tres")

var line_colour = Color.WEB_GRAY

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
		
		line_colour = Color.from_hsv(complemen2ry_colour.x, complemen2ry_colour.y-0.4,complemen2ry_colour.z)
		screen_mat.set_shader_parameter("line_colour", line_colour)
		jaggy_mat.set_shader_parameter("colour", line_colour)
		screen_mat.set_shader_parameter("background_line_colour", Color.from_hsv(complemen2ry_colour.x, complemen2ry_colour.y-0.4,complemen2ry_colour.z-0.4))

func delay_randomise_colour():
	await get_tree().create_timer(2.0).timeout
	colour = colour

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
