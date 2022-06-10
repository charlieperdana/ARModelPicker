//
//  ModelPickerView.swift
//  ModelPickerApp
//
//  Created by Quipper Indonesia on 03/06/22.
//

import SwiftUI

struct ModelPickerView: View {
  @Binding var isPlacementEnabled: Bool
  @Binding var selectedModel : Model?
//  @Binding var selectedModel : String?
  var models  : [Model]
//  var models  : [String]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false){
      HStack(spacing: 30){
        ForEach(0..<self.models.count){ index in
//          Text(self.models[index])
          Button(action: {
//            print("DEBUG: selected model with name: \(self.models[index])")
            print("DEBUG: selected model with name: \(self.models[index].modelName)")
          
            self.selectedModel = self.models[index]
            self.isPlacementEnabled = true
            
          }){
//            Image(uiImage: (UIImage(named: self.models[index]) ?? UIImage(systemName: "square.and.arrow.up.circle.fill"))!)
            Image(uiImage: self.models[index].image)
              .resizable()
              .frame(height: 80)
              .aspectRatio(1/1, contentMode: .fit)
              .background(Color.white)
              .cornerRadius(22)
          }
          //            .buttonStyle(PlainListStyle())
          
          
        }
      }
    }
    .padding(20)
    .background(Color.black.opacity(0.5))
  }
}

struct ModelPickerView_Previews: PreviewProvider {
  @State static var isShown = false
//  @State static var selectedModel: String?
  @State static var selectedModel: Model?
  static var previews: some View {
    ModelPickerView(isPlacementEnabled: $isShown, selectedModel: $selectedModel, models: [Model(modelName: "")])
  }
}
