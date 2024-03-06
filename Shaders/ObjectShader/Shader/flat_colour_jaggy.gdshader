shader_type spatial;
render_mode unshaded;

uniform vec3 colour: source_color = vec3(1.0);
uniform float magnitude = 1;
uniform float time_step = 1;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123) - 0.4;
}


void vertex() {
	// Called for every vertex the material is visible on.
	float rand_num = 0.0;
	if(UV.x == 1.0){
		rand_num = random(UV-vec2(1,0)+ vec2(TIME,TIME)*time_step*time_step*time_step);
	}else{
		rand_num = random(UV+ vec2(TIME,TIME)*time_step*time_step*time_step);
	}
	
	VERTEX = VERTEX + NORMAL * rand_num*magnitude;
}

void fragment() {
	ALBEDO = colour;
}
