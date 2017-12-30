Shader "Custom/Portal/Grid"
{
    Properties
    {
        [HideInInspector]
        _MainTex ("MainTex", 2D) = "white"{}
        _BackgroundColor ("BackgroundColor", Color) = (0.0, 0.0, 0.0, 0.0)
        _GridColor ("GridColor", Color) = (1.0, 1.0, 1.0, 1.0)
    }

    CGINCLUDE
    #include "UnityCG.cginc"

    float4 _BackgroundColor;
    float4 _GridColor;
    
    float4 frag(v2f_img i) : SV_Target
    {
        float2 fst = frac(i.uv * 30);
        return lerp(_BackgroundColor,
                    _GridColor,
                    step(0.9, fst.x) + step(0.9, fst.y));
    }
    ENDCG

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            ENDCG
        }
    }
}
