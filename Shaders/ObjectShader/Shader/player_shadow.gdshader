shader_type spatial;
render_mode unshaded;

uniform vec3 colour: source_color = vec3(1.0);
uniform float threshold;

uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D NORMAL_TEXTURE : hint_normal_roughness_texture, filter_linear_mipmap;

void vertex() {
	NORMAL = vec3(0,1,0);
}

void fragment() {
    // Get the depth value of the current fragment
    float depth = texture(DEPTH_TEXTURE, SCREEN_UV).x;
	vec3 normal = texture(NORMAL_TEXTURE, SCREEN_UV).xyz;
	if(depth < 10.0){
		// Check if the fragment is close to the depth of the original geometry
	    if (abs(depth - FRAGCOORD.z) < threshold*0.04) {
	        // The fragment is inside the intersected geometry
	        // You can apply custom effects here
	        // For example, change the fragment color
	        ALPHA = 0.5;
	    } else {
	        // The fragment is outside the intersected geometry
	        // Use the original fragment color
			ALPHA = 0.0;
	    }
	}else{
		ALPHA = 0.0;
	}

	ALBEDO = colour;
}
