using UnityEngine;

namespace Effects.Portal
{
    public class Portal : MonoBehaviour
    {
        [SerializeField]
        Material portalMaterial;
        [SerializeField]
        Texture insideTexture;
        [SerializeField]
        float radius = 0.15f;

        void Start()
        {
            portalMaterial.SetTexture("_InsideTex", insideTexture);
        }

        void Update()
        {
            var mousePosition = Input.mousePosition;

            var uv = new Vector3(
                mousePosition.x / Screen.width,
                mousePosition.y / Screen.height, 0);
            portalMaterial.SetVector("_Center", uv);

            var fluct = Mathf.Sin(Time.timeSinceLevelLoad * 3) * 0.1f + 0.9f;
            portalMaterial.SetFloat("_Radius", radius * fluct);

            portalMaterial.SetFloat("_Aspect", Screen.height / (float) Screen.width);
        }

        void OnRenderImage(RenderTexture src, RenderTexture dest)
        {
            Graphics.Blit(src, dest, portalMaterial);
        }
    }
}