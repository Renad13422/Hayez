//
//  AppRootView.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 13/08/1447 AH.
//
import SwiftUI

struct AppRootView: View {
    @StateObject private var appState = AppStateViewModel()

    var body: some View {
        Group {
            if appState.isCharacterChosen {
                Mainpage()
            } else {
                CharacterSelectionView()
            }
        }
        .environmentObject(appState)
    }
}
#Preview {
    CharacterSelectionView()
}
