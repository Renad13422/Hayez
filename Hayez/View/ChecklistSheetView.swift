//
//  ChecklistSheetView.swift
//  Hayez
//
//

import SwiftUI

struct ChecklistSheetView: View {
    @EnvironmentObject var appState: AppStateViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // ✅ عرض الصورة حسب الشخصية المختارة
                if let character = appState.selectedCharacter {
                    Image(character.workspaceImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .ignoresSafeArea()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    let appState = AppStateViewModel()
    appState.selectedCharacter = Character(
        name: "Girl",
        imageName: "girlCard",
        gender: .girl,
        workspaceImage: "maingirl"
    )
    
    return ChecklistSheetView()
        .environmentObject(appState)
}
