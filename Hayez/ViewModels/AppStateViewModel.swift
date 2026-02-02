//
//  AppStateViewModel.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 13/08/1447 AH.
//


import Foundation
import Combine


final class AppStateViewModel: ObservableObject {
    @Published var selectedCharacter: Character?

    var isCharacterChosen: Bool { selectedCharacter != nil }

    func selectCharacter(_ character: Character) {
        selectedCharacter = character
    }

    func resetCharacter() {
        selectedCharacter = nil
    }
}
