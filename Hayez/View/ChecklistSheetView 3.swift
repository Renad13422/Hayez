//
//  ChecklistSheetView 3.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 16/08/1447 AH.
//


import SwiftUI

struct ChecklistSheetView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {

                // ✅ الهيدر
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .padding(14)
                    }

                    Spacer()

                    Text("Checklist")
                        .font(.headline)

                    Spacer()

                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.top, 6)
                .padding(.horizontal, 6)

                // ✅ الصورة تمتد وتوزّع المساحة بدل الفراغ تحت
                Image("chicklist")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .clipped()
                    .padding(.horizontal, 0)
                    .padding(.bottom, 0)
            }
            // ✅ أهم سطر: يخلي الـ VStack يعبّي الشيت للنهاية
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}
