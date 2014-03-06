#version 330
in vec3 vertexPosition;
in vec2 vertexTexture;
in vec3 vertexNormal;
uniform mat4 view, proj, model;
out vec3 position;
out vec3 normal;
out vec2 textureCoords;
void main () {
    textureCoords = vertexTexture;
    position = vec3(view*model*vec4(vertexPosition,1.0f));
    normal = vec3(view*model*vec4(vertexNormal,0.0f));
    gl_Position=proj*vec4(position,1.0f);
}