#version 330
in vec3 position;
in vec3 normal;
in vec2 textureCoords;
out vec4 frag_color;
uniform mat4 view;
uniform sampler2D basicTexture;

vec3 lightPosition = vec3(100.0, 400.0, 0.0);
vec3 lightSpec = vec3(0.3,0.3,0.3);
vec3 lightDiffuse = vec3(0.5,0.5,0.5);
vec3 lightAmbient = vec3(0.1,0.1,0.1);

vec3 reflectSpec = vec3(0.1,0.1,0.1);
//vec3 reflectDiffuse = vec3(1.0,0.5,0.0);
vec3 reflectAmbient = vec3(1.0,1.0,1.0);
float power = 100.0f;

void main () {
    vec3 norm = normalize(normal);
    vec4 texel = texture2D(basicTexture,textureCoords);
    vec3 reflectDiffuse = vec3(texel);
    vec3 intenseAmbient = lightAmbient * reflectDiffuse ;
    vec3 lightPositionEye = vec3(view*vec4(lightPosition,1.0));
    vec3 distanceToLight = lightPositionEye - position;
    vec3 directionToLight = normalize(distanceToLight);
    float dotProduct = dot(directionToLight,norm);
    dotProduct = max(dotProduct,0.0);
    vec3 intenseDiffuse = lightDiffuse * reflectDiffuse * dotProduct;
    vec3 reflection = reflect(-directionToLight,norm);
    vec3 surfaceToViewer = normalize(-position);
    float dotProductSpec = dot(reflection,surfaceToViewer);
    dotProductSpec = max(dotProductSpec,0.0);
    float specFactor = pow(dotProductSpec,power);
    vec3 intenseSpec = lightSpec * reflectDiffuse * specFactor * 0.2f;
    vec3 totalLight = intenseSpec+intenseDiffuse+intenseAmbient;
    frag_color=vec4(totalLight,1.0);
}
