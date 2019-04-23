Shader "Hidden/BWDiffuse" {
 Properties {
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _bwBlend ("Black & White blend", Range (0, 1)) = 0
 }
 SubShader {
    Pass {
        CGPROGRAM
        #pragma vertex vert_img
        #pragma fragment frag
        
        #include "UnityCG.cginc"
        
        uniform sampler2D _MainTex;
        uniform float _bwBlend;
        
        float4 frag(v2f_img i) : COLOR {
            float4 c = tex2D(_MainTex, i.uv);
            
            //float lum = c.r*sin(_Time.x) + c.g*sin(_Time.y +0.5) + c.b*sin(_Time.z + .1);
            float3 bw = float3( c.r*sin( (_Time.x* _bwBlend) ), c.g*sin( (_Time.y*_bwBlend + .5) ), c.b*sin( (_Time.z*_bwBlend +.1)) ); 
            
            float4 result = c;
            result.rgb = bw;
            return result;
        }
        ENDCG
    }
 }
}