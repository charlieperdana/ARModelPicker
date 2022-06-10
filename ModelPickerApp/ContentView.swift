//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Quipper Indonesia on 03/06/22.
//

import SwiftUI
import RealityKit
import Foundation
import ARKit
import FocusEntity


struct ContentView : View {
  //  private var models : [String] = ["fender_statocaster",
  //                           "teapot",
  //                           "toy_biplane",
  //                           "toy_robot_vintage"]
  
//  private var models : [String] = {
//    //dynamically get our model filenames
//    let filemanager = FileManager.default
//
//    guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path)
//    else {
//      return []
//    }
//
//    var availableModels: [String] = []
//    for filename in files where
//    filename.hasSuffix("usdz"){
//      let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
//      availableModels.append(modelName)
//    }
//    return availableModels
//  }()
  
  @State private var isPlacementEnabled = false
//  @State private var selectedModel : String?
//  @State private var modelConfirmForPlacement: String?
  //ganti jadi pakai Model
  @State private var selectedModel : Model?
  @State private var modelConfirmForPlacement: Model?
  
  private var models : [Model] = {
    //dynamically get our model filenames
    let filemanager = FileManager.default
    
    guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path)
    else {
      return []
    }
    
    var availableModels: [Model] = []
    for filename in files where
    filename.hasSuffix("usdz"){
      let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
      let model = Model(modelName: modelName)
      availableModels.append(model)
//      availableModels.append(modelName)
    }
    return availableModels
  }()
  
  var body: some View {
    ZStack(alignment: .bottom ) {
      ARViewContainer(modelConfirmForPlacement: $modelConfirmForPlacement)
      
      if self.isPlacementEnabled {
        PlacementButtonView(isPlacementEnable: self.$isPlacementEnabled, selectedmodel: $selectedModel, modelConfirmForPlacement: self.$modelConfirmForPlacement)
      } else {
        ModelPickerView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, models: self.models)
      }
      
      
      
      
      
    }
  }
}

//class CustomARView : ARView {
//  let focusSquare = FocusEntity(on: self.arView, style: .classic(color: .yellow))
//
//}

struct ARViewContainer: UIViewRepresentable {
//  @Binding var modelConfirmForPlacement : String?
  @Binding var modelConfirmForPlacement : Model?
  
  func makeUIView(context: Context) -> ARView {
    
//    let arView = ARView(frame: .zero)
    let arView = CustomARView(frame: .zero)
    
    //config for arkit
    let config = ARWorldTrackingConfiguration()
    config.planeDetection = [.horizontal, .vertical]
    config.environmentTexturing = .automatic
    
    if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
      config.sceneReconstruction = .mesh
    }
    
    arView.session.run(config)
    
    return arView
    
  }
  
  func updateUIView(_ uiView: ARView, context: Context) {
//    if let modelName = self.modelConfirmForPlacement{
//      print("DEBUG: adding model to scene - \(modelName)")
//
//      let filename = modelName + ".usdz"
//      let modelEntity = try! ModelEntity.loadModel(named: filename)
//      //in reality kit, all objects have to be attached to an achor
//      let anchorEntity = AnchorEntity()
//      anchorEntity.addChild(modelEntity)
//
//      uiView.scene.addAnchor(anchorEntity)
//
////      self.modelConfirmForPlacement = nil
//      DispatchQueue.main.async {
//        self.modelConfirmForPlacement = nil
//      }  
//    }
    
    if let model = self.modelConfirmForPlacement{
      if let modelEntity = model.modelEntity {
        print("DEBUG: adding model to scene - \(model.modelName)")
        
        let anchorEntity = AnchorEntity(plane: .any)
//        let anchorEntity = AnchorEntity()
//        anchorEntity.addChild(modelEntity)
        //to solve bug to add the same model more than one
        anchorEntity.addChild(modelEntity.clone(recursive: true))
        
        uiView.scene.addAnchor(anchorEntity)
      } else {
        print("DEBUG: Unable to load modelEntity for - \(model.modelName)")
      }
      
      DispatchQueue.main.async {
        self.modelConfirmForPlacement = nil
      }
      
    }
  }
  
}



#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
