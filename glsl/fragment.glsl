// Copyright 2015 Brandon Ly all rights reserved.
//
// Fragment shader.
//
precision mediump float;

uniform bool UEnvMap;
uniform vec4 UAmbientProduct, UDiffuseProduct, USpecularProduct;
uniform samplerCube USamplerCube;
uniform mat4 UMatViewInv;
uniform mat4 UMatCameraRot;

varying vec3 L, N, E, I;
varying vec3 VTextureCoordSkybox;
varying vec4 VColor;

void main(void)
{
    // Calculate the color/intensities of each respective light.
    vec4 ColorAmbient, ColorDiffuse, ColorSpecular, VColor;

    // // Ambient light.
    // ColorAmbient = UAmbientProduct;

    // // Diffuse light.
    // ColorDiffuse = max(dot(L, N), 0.0) * UDiffuseProduct;

    // // Specular light.
    // ColorSpecular = vec4(0.0, 0.0, 0.0, 0.0);
    // if (dot(E, N) > 0.0) {
    //     // vec3 H = normalize(L + E);
    //     // ColorSpecular = max(pow(max(dot(H, N), 0.0), 20.0) * USpecularProduct, 0.0);
    //     vec3 R = normalize(reflect(-L, N));
    //     ColorSpecular = max(pow(max(dot(E, R), 0.0), 20.0) * USpecularProduct, 0.0);
    // }

    // // Add all the lights up.
    // VColor = (ColorAmbient + ColorDiffuse + ColorSpecular);
    // VColor.a = 1.0;

    // Add environment mapping.
    vec3 LightReflected = reflect(I, N);
    LightReflected = normalize(vec3(UMatCameraRot * vec4(LightReflected, 0.0)));
    VColor = textureCube(USamplerCube, LightReflected);
    VColor.a = 1.0;

    gl_FragColor = VColor;
}
