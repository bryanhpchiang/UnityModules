﻿Shader "Unlit/NewUnlitShader" {
  Properties {
    _MainTex ("Texture", 2D) = "white" {}
  }
  SubShader {
    Tags { "Queue"="Geometry" "RenderType"="Opaque" }

    Pass {
      CGPROGRAM
      #pragma multi_compile _ GUI_SPACE_ALL GUI_SPACE_CYLINDRICAL_CONSTANT_WIDTH GUI_SPACE_CYLINDRICAL_ANGULAR
      #pragma vertex vert
      #pragma fragment frag
      #include "Assets/LeapMotionModules/UI/GuiSpace/Resources/GUiSpace.cginc"
      #include "UnityCG.cginc"

      struct appdata {
        float4 vertex : POSITION;
        float2 uv : TEXCOORD0;
      };

      struct v2f {
        float2 uv : TEXCOORD0;
        float4 vertex : SV_POSITION;
      };

      sampler2D _MainTex;
      float4 _MainTex_ST;
      
      v2f vert (appdata v) {
        v2f o;
        o.vertex = GuiVertToClipSpace(v.vertex);
        o.uv = TRANSFORM_TEX(v.uv, _MainTex);
        return o;
      }
      
      fixed4 frag (v2f i) : SV_Target {
        return tex2D(_MainTex, i.uv);
      }
      ENDCG
    }
  }
}
