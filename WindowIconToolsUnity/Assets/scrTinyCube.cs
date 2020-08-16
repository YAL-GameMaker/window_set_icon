using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scrTinyCube : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var dt = Time.deltaTime * 3;
        transform.rotation *= Quaternion.Euler(dt * 5, dt * 5, dt * 5);
    }
}
