shader_type canvas_item;
render_mode unshaded;

uniform float pixel_factor : hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float noise_factor : hint_range(0.0,0.01,0.01) = 0;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123) * 2.0 - 1.0;
}

float random2 (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(23.2495,48.853))) * 46238.54556223) * 2.0 - 1.0;
}


void fragment() {
	vec2 pixelNumber = vec2(textureSize(TEXTURE, 0)) * pixel_factor;
	vec2 random_offset = vec2((pixelNumber.x * random(UV)*noise_factor*5.0), (pixelNumber.y * random2(UV)*noise_factor*5.0));
	vec2 pixelatedUV = (UV * pixelNumber + random_offset) / pixelNumber;
	COLOR.xyz = texture(TEXTURE, pixelatedUV).xyz * (pixel_factor*0.2 + 0.8);

}
