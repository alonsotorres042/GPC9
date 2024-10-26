Shader "Custom/WavingFlag"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _WaveStrength("Wave Strength", Float) = 0.1
        _WaveFrequency("Wave Frequency", Float) = 2.0
        _WaveSpeed("Wave Speed", Float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float _WaveStrength;
            float _WaveFrequency;
            float _WaveSpeed;

            v2f vert(appdata v)
            {
                v2f o;
                float time = _Time.y * _WaveSpeed;

                float wave = sin(v.vertex.x * _WaveFrequency + time) * _WaveStrength;
                v.vertex.z += wave;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}