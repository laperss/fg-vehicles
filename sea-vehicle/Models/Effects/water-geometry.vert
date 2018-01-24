// -*-C++-*-
//  Water geometry vertex shader function.
//
//  Copyright (C) 2013 - 2017  Anders Gidenstam  (anders(at)gidenstam.org)
//  This file is licensed under the GPL license version 2 or later.

#version 120

uniform float wave_time_sec;
uniform float waves_from_deg;
uniform float wave_length_ft;
uniform float wave_amplitude_ft;
uniform float wave_angular_frequency_rad_sec;
uniform float wave_number_rad_ft;
//uniform float speed_north_fps;
//uniform float speed_east_fps;

void water_geometry_func(out vec4 oPosition, out vec3 oNormal)
{
    // Compute vertex position in object space.
    vec2 wave_direction = vec2(-cos(0.017453293*waves_from_deg),
                               sin(0.017453293*waves_from_deg));
    oPosition = gl_Vertex;
    oNormal   = gl_Normal;

    float k = 3.2808399 * wave_number_rad_ft;         // [rad/m]
    float omega = wave_angular_frequency_rad_sec;     // [rad/s]
    float amplitude = 0.3048 * wave_amplitude_ft;     // [m]
    float angle =                                     // [rad]
      dot(wave_direction, oPosition.xy) * k  - omega * wave_time_sec;

    float h = amplitude * cos(angle);

    // Reduce amplitude and level towards the edges.
    float d = clamp(1.0 - 0.005 * (length(oPosition.xy) - 50.0), 0.01, 1.0);
    oPosition.z += h*sqrt(d);

    // Compute the vertex normal.
    float a = atan(amplitude * sin(angle) * k);
    oNormal = vec3(sin(a) * wave_direction, cos(a));
    oNormal = normalize(oNormal);
}
