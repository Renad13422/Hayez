//
//  HayezActivityAttributes.swift
//  Hayez
//
//  Created by ريناد محمد حملي on 22/08/1447 AH.
//

//
// HayezActivityAttributes.swift
// LiveActivity
////

import ActivityKit
import Foundation

struct HayezActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var endTime: Date
    }
    
    var characterName: String
}
