import QtQuick 2.1
import Qt3D.Core 2.0
import Qt3D.Render 2.9
import Qt3D.Input 2.0
import Qt3D.Extras 2.9

Entity {
    id: scene
    enabled: true

    // Свет
    Entity {
        components: [
            DirectionalLight {
                worldDirection: Qt.vector3d(2.0, -6.0, 10.0).normalized();
                color: "#FFFFFF"
                intensity: 1.0
            }
        ]
    }

    // Камера
    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 16/9
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( 0.0, 5.0, -20.0 )
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 5.0, 0.0 )
    }

    OrbitCameraController {
        camera: camera
    }

    components: [
        RenderSettings {
            activeFrameGraph: ForwardRenderer {
                clearColor: Qt.rgba(0, 0.5, 1, 1) // небо
                camera: camera
            }
        },
        InputSettings { }
    ]

    // Дерево
    Mesh { 
        id: treeMesh;
        source: "data/tree.obj"
    }
    
    TexturedMetalRoughMaterial {
        id: treeMaterial
        baseColor: TextureLoader {
            source: "data/texture/TexturesCom_TreeBark2_512_albedo.tif"
            generateMipMaps: true
        }
        metalness: TextureLoader { source: "data/texture/TexturesCom_TreeBark2_512_height.tif"; generateMipMaps: true }
        roughness: TextureLoader { source: "data/texture/TexturesCom_TreeBark2_512_roughness.tif"; generateMipMaps: true }
        normal: TextureLoader { source: "data/texture/TexturesCom_TreeBark2_512_normal.tif"; generateMipMaps: true }
        ambientOcclusion: TextureLoader { source: "data/texture/TexturesCom_TreeBark2_512_ao.tif" }
    }

    Entity {
        id: tree
        components: [treeMesh, treeMaterial]
    }

    // Листья
    Entity {
        id: leavesEntity
        components: [
            Mesh {
                source: "data/leaves.obj"
            },
            TexturedMetalRoughMaterial {
                baseColor: "#8000FF00"
            }
        ]
    }
    
    // Трава
    Texture2D{
        id: texture
        TextureImage {
            source: "qrc:/data/texture/TexturesCom_Grass0027_1_seamless_S.jpg"
        }
    }

    NodeInstantiator{
        id: grid
        property int rows: 50
        property int columns: 50
        model: rows*columns

        Entity {
            property int _row: index /  grid.columns
            property int _col: index % grid.columns

            components: [
                PlaneMesh {
                    width: 1
                    height: width
                },
                Transform {
                    translation: Qt.vector3d(_row-grid.columns/2, 0,_col-grid.columns/2)
                },
                DiffuseMapMaterial {
                    diffuse: texture
                }
            ]
        }
    }

    // Текст
    Text2DEntity{
        id:text
        height:20
        width:45
        font.family: "Helvetica"
        font.pixelSize: 8
        font.weight: Font.Light
        text: "Aloha!"
        color:"white"

        components: [
            Transform {
                translation: Qt.vector3d(5,4,-5)
                rotationZ:0
                rotationY:180
                rotationX:0
                scale3D: Qt.vector3d(0.2,0.2,1.0)
            }
        ]
    }
}
