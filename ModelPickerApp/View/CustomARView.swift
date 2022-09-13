//
//  CustomARView.swift
//  ModelPickerApp
//
//  Created by Quipper Indonesia on 03/06/22.
//

import Foundation
import RealityKit
import FocusEntity
import SwiftUI
import ARKit

class CustomARView: ARView {
  enum FocusStyleChoices {
    case classic
    case material
    case color
  }

  /// Style to be displayed in the example
  let focusStyle: FocusStyleChoices = .classic
  var focusEntity: FocusEntity?
  
  required init(frame frameRect: CGRect) {
    super.init(frame: frameRect)
    
    switch focusStyle {
    case .color:
      focusEntity = FocusEntity(on: self, focus: .plane)
    case .material:
      do {
        let onColor: MaterialColorParameter = try .texture(.load(named: "Add"))
        let offColor: MaterialColorParameter = try .texture(.load(named: "Open"))
        focusEntity = FocusEntity(
          on: self,
          style: .colored(
            onColor: onColor, offColor: offColor,
            nonTrackingColor: offColor
          )
        )
      } catch {
        focusEntity = FocusEntity(on: self, focus: .classic)
        print("Unable to load plane textures")
        print(error.localizedDescription)
      }
    default:
      focusEntity = FocusEntity(on: self, focus: .classic)
    }
    
    setupARView()
  }
  
  @MainActor required dynamic init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupARView() {
    //config for arkit
    let config = ARWorldTrackingConfiguration()
    config.planeDetection = [.horizontal, .vertical]
    config.environmentTexturing = .automatic
    
    if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
      config.sceneReconstruction = .mesh
    }
    
    self.session.run(config)
  }
}

extension CustomARView: FocusEntityDelegate {
  func toTrackingState() {
    print("tracking")
  }
  func toInitializingState() {
    print("initializing")
  }
}
