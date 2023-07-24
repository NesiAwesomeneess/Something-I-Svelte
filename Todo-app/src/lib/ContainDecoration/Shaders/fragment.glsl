
varying vec2 vUv;

struct ColorStop {
    vec3 color;
    float position;
};

ColorStop[5] palette = ColorStop[](
    ColorStop(vec3(0.11, 0.11, 0.12), 0.0),
    ColorStop(vec3(0.11, 0.11, 0.12), 0.3),
    ColorStop(vec3(0.34, 0.23, 0.68), 0.6),
    ColorStop(vec3(0.43, 0.56, 0.92), 0.8),
    ColorStop(vec3(0.96, 0.94, 0.88), 1.0)
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
    float staticNoise = random(randomUV) * 0.03;

    float factor = gradient - staticNoise;

    vec3 finalColor;
    ColorRamp(palette, factor, finalColor);

    gl_FragColor = vec4(finalColor, 1.0);
}