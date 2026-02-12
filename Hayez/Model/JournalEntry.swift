//
//  JournalEntry.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 13/08/1447 AH.
//

import SwiftUI
import ActivityKit

struct TestLiveActivityButton: View {
    var body: some View {
        Button("🚀 تجربة Live Activity") {
            startLiveActivity()
        }
        .padding()
        .background(Color.orange)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    func startLiveActivity() {
        let attributes = HayezActivityAttributes(characterName: "أسامة")
        let contentState = HayezActivityAttributes.ContentState(
            endTime: Date().addingTimeInterval(25 * 60) // 25 دقيقة
        )
        
        do {
            let activity = try Activity<HayezActivityAttributes>.request(
                attributes: attributes,
                content: .init(state: contentState, staleDate: nil)
            )
            print("✅ Live Activity بدأ! ID: \(activity.id)")
        } catch {
            print("❌ خطأ: \(error)")
        }
    }
}
