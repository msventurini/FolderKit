////
//  ContentView.swift
//  testeUIBezier
//
//  Created by Matheus Silveira Venturini on 23/04/24.
//

import SwiftUI
import SceneKit


struct ContentView: View {
    
    var path = Path(Folder(topSizeModifier: 0)
        .path(in: .init(x: 0, y: 0, width: 400, height: 300)).cgPath)
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            Path(Folder(topSizeModifier: 0)
                .path(in: .init(x: geometry.frame(in: .local).minX, y: geometry.frame(in: .local).midY, width: geometry.size.width, height: geometry.size.height)).cgPath)
            
        }
    }
}

#Preview {
//    ContentView()
    Folder3DView()
}



struct Folder3DView: View {

    private let scene = FolderScene()
    
    
    var body: some View {
        SceneView(scene: scene, options: [.allowsCameraControl])
    }

    static func createCameraNode() -> SCNNode {
       let cameraNode = SCNNode()
       cameraNode.camera = SCNCamera()
       return cameraNode
    }
}

class FolderScene: SCNScene {
    
    private var folderNode: SCNNode?

    override init() {
        super.init()
        addFolder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addFolder() {
        let folderMaterial = SCNMaterial()
        folderMaterial.diffuse.contents = UIColor(ciColor: .blue)
           
        let folderGeometry = SCNShape(path: UIBezierPath(cgPath: Folder(topSizeModifier: 0)
            .path(in: .init(x: 0, y: 0, width: 200, height: 100)).cgPath), extrusionDepth: 20) //SCNSphere(radius: 1)
        folderGeometry.materials = [folderMaterial]

        let folderNode = SCNNode(geometry: folderGeometry)
        folderNode.position = SCNVector3(0, 0, 0)
        self.rootNode.addChildNode(folderNode)
        self.folderNode = folderNode
    }
}
