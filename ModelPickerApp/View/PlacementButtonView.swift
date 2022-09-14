//
//  PlacementButtonView.swift
//  ModelPickerApp
//
//  Created by Quipper Indonesia on 03/06/22.
//

import SwiftUI

struct PlacementButtonView: View {
  @Binding var isPlacementEnable: Bool
  @Binding var selectedmodel: Model?
  @Binding var modelConfirmForPlacement: Model?
//  @Binding var selectedmodel: String?
//  @Binding var modelConfirmForPlacement: String?
  
  var body: some View {
    HStack {
      //Cancel Button
      Button {
        print("DEBUG: model placement cancel.")
        reserPlacementParameters()
      } label: {
        buttonImage(systemName: "xmark")
      }
      
      //Confirm Button
      Button {
        print("DEBUG: model placement confirmed.")
        modelConfirmForPlacement  = selectedmodel
        reserPlacementParameters()
      } label: {
        buttonImage(systemName: "checkmark")
      }
    }
  }

  @ViewBuilder
  private func buttonImage(systemName: String) -> some View {
    Image(systemName: systemName)
      .frame(width: 60, height: 60)
      .font(.title)
      .background(Color.white.opacity(0.75))
      .cornerRadius(30)
      .padding(20)
  }
  
  func reserPlacementParameters() {
    isPlacementEnable = false
    selectedmodel = nil
  }
}

struct PlacementButtonView_Previews: PreviewProvider {
  @State static var isShown = false
//  @State static var selectedModel: String? = ""
//  @State static var modelConfirmForPlacement: String? = ""
  @State static var selectedModel: Model?
  @State static var modelConfirmForPlacement: Model?
  static var previews: some View {
    PlacementButtonView(isPlacementEnable: $isShown, selectedmodel: $selectedModel, modelConfirmForPlacement: $modelConfirmForPlacement)
  }
}
