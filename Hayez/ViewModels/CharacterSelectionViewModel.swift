//
//  CharacterSelectionviewModel.swift
//  Hayez
//
//  Created by ريناد محمد حملي on 16/08/1447 AH.
//

import Foundation
import Combine

class CharacterSelectionViewModel: ObservableObject {
    
    @Published var characters: [Character] = [
        Character(
            name: "Girl",
            imageName: "girlCard",
            gender: .girl,
            workspaceImage: "maingirl"
        ),
        Character(
            name: "Boy",
            imageName: "boyCard",
            gender: .boy,
            workspaceImage: "mainboy"
        )
    ]
}
