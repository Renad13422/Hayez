//
//  CharacterSelectionViewModel.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 13/08/1447 AH.
//

import Foundation
import Combine


final class CharacterSelectionViewModel: ObservableObject {
    @Published var characters: [Character] = [
        Character(name: "Girl", imageName: "girlCard", gender: .girl),
        Character(name: "Boy",  imageName: "boyCard",  gender: .boy)
    ]
}
