//
//  JournalView.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 13/08/1447 AH.
//
import SwiftUI

struct JournalView: View {
    var body: some View {
        Image("jornal")   // ✅ اسمها كذا عندك بالـ Assets
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Journal")
    }
}
