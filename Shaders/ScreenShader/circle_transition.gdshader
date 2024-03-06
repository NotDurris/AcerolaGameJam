shader_type canvas_item;
render_mode unshaded;

uniform vec3 colour: source_color = vec3(1.0);
uniform vec2 cutout_position;
uniform float cutout_size;
uniform float cutout_fall_off_size;

const float e = 2.71828182845;

float Get_Distance(vec2 a, vec2 b){
	return sqrt((a.x-b.x) * (a.x-b.x) + (a.y-b.y) * (a.y-b.y));
}

float sigmoid(float edge_1, float edge_2,float a){
	return (((1.0 / (1.0+pow(e,-a))) - edge_1)*2.0)*edge_2;
}

float Dither_float(float value, vec2 uv)
{
    float DITHER_THRESHOLDS[16] =
    {
        1.0 / 17.0,  9.0 / 17.0,  3.0 / 17.0, 11.0 / 17.0,
        13.0 / 17.0,  5.0 / 17.0, 15.0 / 17.0,  7.0 / 17.0,
        4.0 / 17.0, 12.0 / 17.0,  2.0 / 17.0, 10.0 / 17.0,
        16.0 / 17.0,  8.0 / 17.0, 14.0 / 17.0,  6.0 / 17.0
    };
    uint index = (uint(uv.x) % uint(4)) * uint(4) + uint(uv.y) % uint(4);
    return value - DITHER_THRESHOLDS[index];
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float edge_1 = cutout_size - cutout_fall_off_size;
	float edge_2 = cutout_size;
	
	float aspect_ratio = (1.0/SCREEN_PIXEL_SIZE.x) / (1.0/SCREEN_PIXEL_SIZE.y);
	vec2 a = vec2(SCREEN_UV.x, SCREEN_UV.y/aspect_ratio);
	vec2 b = vec2(cutout_position.x, cutout_position.y/aspect_ratio);
	
	float dist = Get_Distance(a,b);
	
	COLOR = vec4(colour,clamp(Dither_float(2.0*clamp(smoothstep(edge_1,edge_2,dist),0,1),SCREEN_UV / SCREEN_PIXEL_SIZE),0,1));
}