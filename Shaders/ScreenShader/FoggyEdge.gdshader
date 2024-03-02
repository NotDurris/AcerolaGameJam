shader_type spatial;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D DEPTH_TEXTURE: hint_depth_texture, filter_linear_mipmap;
uniform sampler2D NORMAL_TEXTURE : hint_normal_roughness_texture, filter_linear_mipmap;

uniform float edge_threshold = 0.1;
uniform float fog_depth_threshold = 20.0;
uniform float fog_falloff = 0.5;
uniform vec3 line_colour: source_color = vec3(1.0);
uniform vec3 background_colour: source_color = vec3(0.0);
uniform vec3 background_line_colour: source_color = vec3(0.0);

const mat3 sobel_y = mat3(
	vec3(1.0, 0.0, -1.0),
	vec3(2.0, 0.0, -2.0),
	vec3(1.0, 0.0, -1.0)
);

const mat3 sobel_x = mat3(
	vec3(1.0, 2.0, 1.0),
	vec3(0.0, 0.0, 0.0),
	vec3(-1.0, -2.0, -1.0)
);

float linearize_depth(vec2 uv_coord, mat4 proj_matrix){
	float depth = texture(DEPTH_TEXTURE, uv_coord).x;
	vec3 ndc = vec3(uv_coord, depth) * 2.0 - 1.0;
	vec4 view = proj_matrix * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = -view.z;
	return linear_depth;
}

void vertex(){
	POSITION = vec4(VERTEX, 1.0);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec4 screen_colour = texture(SCREEN_TEXTURE, uv);
	
	vec3 normal = texture(NORMAL_TEXTURE, uv).rgb;
	normal = normal * 2.0 - 1.0;

	float depth = linearize_depth(uv, INV_PROJECTION_MATRIX);

	vec2 offset = 0.5 / VIEWPORT_SIZE;

	float n = linearize_depth(uv + vec2(0.0, -offset.y), INV_PROJECTION_MATRIX);
	float s = linearize_depth(uv + vec2(0.0, offset.y), INV_PROJECTION_MATRIX);
	float e = linearize_depth(uv + vec2(offset.x, 0.0), INV_PROJECTION_MATRIX);
	float w = linearize_depth(uv + vec2(-offset.x, 0.0), INV_PROJECTION_MATRIX);
	float nw = linearize_depth(uv + vec2(-offset.x, -offset.y), INV_PROJECTION_MATRIX);
	float ne = linearize_depth(uv + vec2(offset.x, -offset.y), INV_PROJECTION_MATRIX);
	float sw = linearize_depth(uv + vec2(-offset.x, offset.y), INV_PROJECTION_MATRIX);
	float se = linearize_depth(uv + vec2(offset.x, offset.y), INV_PROJECTION_MATRIX);
	
	vec3 n_1 = texture(NORMAL_TEXTURE, uv + vec2(0.0, -offset.y)).rgb;
	vec3 s_1 = texture(NORMAL_TEXTURE, uv + vec2(0.0, offset.y)).rgb;
	vec3 e_1 = texture(NORMAL_TEXTURE, uv + vec2(offset.x, 0.0)).rgb;
	vec3 w_1 = texture(NORMAL_TEXTURE, uv + vec2(-offset.x, 0.0)).rgb;
	vec3 nw_1 = texture(NORMAL_TEXTURE, uv + vec2(-offset.x, -offset.y)).rgb;
	vec3 ne_1 = texture(NORMAL_TEXTURE, uv + vec2(offset.x, -offset.y)).rgb;
	vec3 sw_1 = texture(NORMAL_TEXTURE, uv + vec2(-offset.x, offset.y)).rgb;
	vec3 se_1 = texture(NORMAL_TEXTURE, uv + vec2(offset.x, offset.y)).rgb;
	
	// Depth based edge detection with slight normal help
	mat3 surrounding_pixels = mat3(
		vec3(nw, n, ne),
		vec3(w, depth, e),
		vec3(sw, s, se)
	);

	float edge_x = dot(sobel_x[0], surrounding_pixels[0]) + dot(sobel_x[1], surrounding_pixels[1]) + dot(sobel_x[2], surrounding_pixels[2]);
	float edge_y = dot(sobel_y[0], surrounding_pixels[0]) + dot(sobel_y[1], surrounding_pixels[1]) + dot(sobel_y[2], surrounding_pixels[2]);
	
	float edge = 0.0;
	if (n_1 != s_1){
		edge = sqrt(pow(edge_x, 2.0)+pow(edge_y, 2.0));
	}
	
	// Normal based edge detection
	surrounding_pixels = mat3(
		vec3(length(nw_1-normal), length(n_1-normal), length(ne_1-normal)),
		vec3(length(w_1-normal), length(normal-normal), length(e_1-normal)),
		vec3(length(sw_1-normal), length(s_1-normal), length(se_1-normal))
	);

	edge_x = dot(sobel_x[0], surrounding_pixels[0]) + dot(sobel_x[1], surrounding_pixels[1]) + dot(sobel_x[2], surrounding_pixels[2]);
	edge_y = dot(sobel_y[0], surrounding_pixels[0]) + dot(sobel_y[1], surrounding_pixels[1]) + dot(sobel_y[2], surrounding_pixels[2]);

	float edge_1 = sqrt(pow(edge_x, 2.0)+pow(edge_y, 2.0));
	
	// Add Fog and edges
	if (depth > fog_depth_threshold){
		float depth_thresh = (depth - fog_depth_threshold) * fog_falloff;
		float depth_multiplier = clamp(depth_thresh,0,1) * clamp(depth_thresh,0,1);
		if (edge > edge_threshold || edge_1 > edge_threshold) {
			ALBEDO = mix(line_colour, background_line_colour, depth_multiplier);
		}else{
			ALBEDO = mix(screen_colour.xyz, background_colour, depth_multiplier);
		}
	}else {
		if (edge > edge_threshold || edge_1 > edge_threshold) {
			ALBEDO = line_colour;
		}else{
			ALBEDO = screen_colour.xyz;
		}
	}
}