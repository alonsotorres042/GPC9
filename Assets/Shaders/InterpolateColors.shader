Shader "Unlit/InterpolateColors"
{
    Properties
    {
        _ColorA("Color A", Color) = (0, 0, 0, 1)
        _ColorB("Color B", Color) = (1, 1, 1, 1)
        _Interpolation("Interpolation", Range(0, 1)) = 0.5
    }
        SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            fixed4 _ColorA;
            fixed4 _ColorB;
            float _Interpolation;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return lerp(_ColorA, _ColorB, _Interpolation);
            }
            ENDCG
        }
    }
}