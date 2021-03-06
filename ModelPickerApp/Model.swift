//
//  Modell.swift
//  ModelPickerApp
//
//  Created by Quipper Indonesia on 03/06/22.
//

import UIKit
import RealityKit
import Combine

class Model {
  var modelName: String
  var image: UIImage
  var modelEntity: ModelEntity?
  
  private var cancellable: AnyCancellable? = nil
  
  init(modelName: String) {
    self.modelName = modelName
    
    self.image = UIImage(named: modelName)!
    
    let filename = modelName + ".usdz"
    self.cancellable = ModelEntity.loadModelAsync(named: filename)
      .sink(receiveCompletion: { loadCompletion in
        //handle our error
        print("DEBUG: Unable to load ,odelentity for modelname: \(self.modelName)")
      }, receiveValue: { modelEntity in
        //get our modelEntity
        self.modelEntity = modelEntity
        print("DEBUG: Successfully loaded modelEntity for modelname: \(self.modelName)")
      })
  }
}
