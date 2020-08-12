{
    "id": "897059ab-6c2a-4b63-a648-db09480cff45",
    "modelName": "GMExtension",
    "mvc": "1.2",
    "name": "window_set_icon",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        
    ],
    "androidProps": true,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": 113497714299118,
    "date": "2019-34-12 01:12:29",
    "description": "",
    "exportToGame": true,
    "extensionName": "",
    "files": [
        {
            "id": "bac80d6c-a2e2-445c-9d9d-6141adb131a5",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "window_set_icon.dll",
            "final": "",
            "functions": [
                {
                    "id": "2d3d2066-3b35-e02f-e8c2-07b38f245580",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        1,
                        1,
                        1
                    ],
                    "externalName": "window_set_icon_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "window_set_icon_raw",
                    "returnType": 2
                },
                {
                    "id": "c3d3ce88-2a24-f1c1-351f-2591a9bdff2e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "window_reset_icon_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "window_reset_icon_raw",
                    "returnType": 2
                },
                {
                    "id": "d2c2df99-3b35-e0d0-4268-52e6d31733ef",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "window_set_overlay_icon_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "window_set_overlay_icon_raw",
                    "returnType": 2
                },
                {
                    "id": "a5b5a8ee-d5db-0ea7-604a-e95d6d6011c8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "window_reset_overlay_icon_raw",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "window_reset_overlay_icon_raw",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                "d2c2df99-3b35-e0d0-4268-52e6d31733ef"
            ],
            "origname": "extensions\\window_set_icon.dll",
            "uncompress": false
        },
        {
            "id": "7cc73678-e3b5-432b-8372-a1d5779ceb4b",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                {
                    "id": "5a4a5711-e6e8-3d58-e8c2-ad19216066b7",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "window_set_icon_hresult",
                    "hidden": false,
                    "value": "global.g_window_set_icon_hresult"
                },
                {
                    "id": "1e0e1355-a2ac-791c-173d-52e6d9e85583",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "window_set_icon_context",
                    "hidden": false,
                    "value": "global.g_window_set_icon_context"
                }
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "window_set_icon.gml",
            "final": "",
            "functions": [
                {
                    "id": "a1dab906-3974-f8b0-55ba-2de0f42c5fa4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "window_set_icon_init",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "window_set_icon_init",
                    "returnType": 2
                },
                {
                    "id": "0f1f0244-e6e8-3d0d-604a-70c4fa8e5582",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_set_icon",
                    "help": "window_set_icon(path_to_an_ico)",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_set_icon",
                    "returnType": 2
                },
                {
                    "id": "7a610206-73de-e9af-a9cd-103ea7ff6c2c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_set_icon_buffer",
                    "help": "window_set_icon_buffer(buffer_with_an_ico_inside)",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_set_icon_buffer",
                    "returnType": 2
                },
                {
                    "id": "b2e98a8e-6b56-612e-beab-e65ea3181b4a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "window_reset_icon",
                    "help": "window_reset_icon()",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_reset_icon",
                    "returnType": 2
                },
                {
                    "id": "a3f89b9f-10ed-da99-c4ba-9de8c59c5fb5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "window_set_overlay_icon",
                    "help": "window_set_overlay_icon(path_to_an_ico, description)",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_set_overlay_icon",
                    "returnType": 2
                },
                {
                    "id": "0eb44392-1270-2a56-4d9b-b5ef82e6f8be",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "window_set_overlay_icon_buffer",
                    "help": "window_set_overlay_icon_buffer(buffer_with_an_ico_inside, description)",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_set_overlay_icon_buffer",
                    "returnType": 2
                },
                {
                    "id": "448fec71-ab56-f8bb-e3fe-8cfc11d81bc2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "window_reset_overlay_icon",
                    "help": "window_reset_overlay_icon()",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_reset_overlay_icon",
                    "returnType": 2
                }
            ],
            "init": "window_set_icon_init",
            "kind": 2,
            "order": [
                "a1dab906-3974-f8b0-55ba-2de0f42c5fa4",
                "a3f89b9f-10ed-da99-c4ba-9de8c59c5fb5",
                "0eb44392-1270-2a56-4d9b-b5ef82e6f8be"
            ],
            "origname": "extensions\\gml.gml",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": true,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosdelegatename": "",
    "iosplistinject": "",
    "license": "Proprietary",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "options": null,
    "optionsFile": "options.json",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "supportedTargets": 113497714299118,
    "tvosProps": false,
    "tvosSystemFrameworkEntries": [
        
    ],
    "tvosThirdPartyFrameworkEntries": [
        
    ],
    "tvosclassname": "",
    "tvosdelegatename": "",
    "tvosmaccompilerflags": "",
    "tvosmaclinkerflags": "",
    "tvosplistinject": "",
    "version": "1.0.0"
}