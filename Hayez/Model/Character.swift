//
//  Character.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 13/08/1447 AH.
//

import Foundation

struct Character: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let imageName: String
    let gender: Gender

    enum Gender: String, Codable {
        case girl, boy
    }

    init(id: UUID = UUID(), name: String, imageName: String, gender: Gender) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.gender = gender
    }
}
