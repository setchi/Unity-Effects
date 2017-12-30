Shader "Custom/Portal"
{
    Properties
    {
        _MainTex ("MainTex", 2D) = "white"{}
    }

    CGINCLUDE
    #include "UnityCG.cginc"

    sampler2D _MainTex;
    sampler2D _InsideTex;
    float _Aspect;
    float _Radius;
    float2 _Center;

    // Transform UV for Portal Effect
    // .xy = uv for portal effect
    // .z  = 1: inside, 0: outside
    float3 transform_uv(float2 uv)
    {
        float width = 0.07;

        float distance_to_center = length((_Center - uv) * float2(1, _Aspect));
        float distortion = 1 - smoothstep(_Radius - width, _Radius, distance_to_center);
        
        uv += (_Center - uv) * distortion;

        return float3(uv, step(1, distortion));
    }
    
    float4 frag_portal(v2f_img i) : SV_Target
    {
        float3 portal = transform_uv(i.uv);
        return lerp(tex2D(_MainTex, portal.xy),
                    tex2D(_InsideTex, i.uv),
                    portal.z);
    }
    ENDCG

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag_portal
            ENDCG
        }
    }
}
