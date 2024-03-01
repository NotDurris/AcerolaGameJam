shader_type spatial;
render_mode unshaded;

uniform vec3 colour: source_color = vec3(1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = colour;
}
