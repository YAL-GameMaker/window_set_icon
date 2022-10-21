using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IconTester : MonoBehaviour
{
    public Texture2D texture;
    public Texture2D cursorTexture;
    public Camera iconCamera;
    // Start is called before the first frame update
    Texture2D ConvertTexture(Texture2D texture, TextureFormat format) {
        var tex = new Texture2D(texture.width, texture.height, format, false);
        tex.SetPixels32(texture.GetPixels32());
        return tex;
    }

    void Start()
    {
        texture = ConvertTexture(texture, TextureFormat.BGRA32);
        cursorTexture = new Texture2D(32, 32, TextureFormat.RGBA32, false);
        WindowIconTools.SetOverlayIcon(texture);
        WindowIconTools.SetIcon(texture, WindowIconKind.Small);
        WindowIconTools.SetIcon(texture, WindowIconKind.Big);
        var rtx = iconCamera.targetTexture;
        texture = new Texture2D(rtx.width, rtx.height, TextureFormat.BGRA32, false);
    }

    private Texture2D tempTexture0;
    private Texture2D tempTexture1;
	private void Update() {
        var rtx = iconCamera.targetTexture;
        var tex = texture;
        RenderTexture.active = rtx;
        tex.ReadPixels(new Rect(0, 0, rtx.width, rtx.height), 0, 0);
        tex.Apply();
        WindowIconTools.SetIcon(tex, WindowIconKind.Small);
        WindowIconTools.SetIcon(tex, WindowIconKind.Big);
        //
        cursorTexture.ReadPixels(new Rect(0, 0, rtx.width, rtx.height), 0, 0);
        cursorTexture.Apply();
        var ctx = new Texture2D(32, 32, TextureFormat.RGBA32, false);
        ctx.SetPixels32(texture.GetPixels32());
        tempTexture0 = tempTexture1;
        tempTexture1 = ctx;
        if (tempTexture0 != null) Cursor.SetCursor(tempTexture0, Vector2.zero, CursorMode.Auto);
    }

	private void OnDisable() {
        WindowIconTools.SetOverlayIcon(null);
        WindowIconTools.SetIcon(null, WindowIconKind.Big);
        WindowIconTools.SetIcon(null, WindowIconKind.Small);
    }
}
