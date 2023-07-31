
varying vec2 vUv;

struct ColorStop {
    vec3 color;
    float position;
};

ColorStop[5] palette = ColorStop[](
    ColorStop(vec3(0.071,0.086,0.122), 0.0),
    ColorStop(vec3(0.098,0.11,0.141), 0.1),
    ColorStop(vec3(0.45, 0.42, 0.8), 0.55),
    ColorStop(vec3(1.,0.894,0.839), 0.9),
    ColorStop(vec3(0.949,0.922,0.918), 1.0)
);

#define ColorRamp(colors, factor, finalColor) { \
    int index = 0; \
    for(int i = 0; i < colors.length() - 1; i++){ \
       ColorStop currentColor = colors[i]; \
       bool isInBetween = currentColor.position <= factor; \
       index = int(mix(float(index), float(i), float(isInBetween))); \
    } \
    ColorStop currentColor = colors[index]; \
    ColorStop nextColor = colors[index + 1]; \
    float range = nextColor.position - currentColor.position; \
    float lerpFactor = (factor - currentColor.position) / range; \
    finalColor = mix(currentColor.color, nextColor.color, lerpFactor); \
} \

float random(vec2 p){
    vec2 k1 = vec2(
        23.14869263277926,
        2.665144142690225
    );
    return fract(
        cos(dot(p, k1)) * 12345.6789
    );
}

void main(){
    float d = 1.0 - length(vUv - vec2(0.5, 0.95));
    float gradient = smoothstep(0.0, 1.0, d);

    //GRAIN
    vec2 randomUV = vec2(random(vUv));
    float staticNoise = random(randomUV) * 0.04;

    float factor = gradient - staticNoise;

    vec3 finalColor;
    ColorRamp(palette, factor, finalColor);

    gl_FragColor = vec4(finalColor, 1.0);
}