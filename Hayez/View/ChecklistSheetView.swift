//
//  ChecklistSheetView 3.swift
//  Hayez
//
//


import SwiftUI

struct ChecklistSheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .top) {
            // ✅ السطر الأول لضمان الشفافية
            Color.clear.ignoresSafeArea()

            VStack(spacing: 0) {
                // الهيدر (زر الإغلاق)
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray.opacity(0.6))
                            .padding()
                    }
                    Spacer()
                }

                // صورة الورقة
                Image("chicklist")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        // ✅ السطر الثاني لإزالة أي لون خلفية متبقي
        .background(Color.clear)
    }
}


#Preview {
    ChecklistSheetView()
}

