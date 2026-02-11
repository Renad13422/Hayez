//
//  ChecklistSheetView 3.swift
//  Hayez
//
//

import SwiftUI

struct ChecklistSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var item1 = ""
    @State private var item2 = ""
    @State private var item3 = ""
    @State private var item4 = ""
    @State private var item5 = ""
    @State private var item6 = ""
    
    @State private var isChecked1 = false
    @State private var isChecked2 = false
    @State private var isChecked3 = false
    @State private var isChecked4 = false
    @State private var isChecked5 = false
    @State private var isChecked6 = false
    
    @FocusState private var focusedIndex: Int?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear.ignoresSafeArea()
            
            VStack(spacing: 0) {
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
                
                ZStack {
                    Image("chicklist")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                    VStack(spacing: 14) {
                        // سطر 1
                        checklistRow(text: $item1, isChecked: $isChecked1, index: 0, xOffset: 400, yOffset: -70, checkX: -455, checkY: -70)
                        
                        // سطر 2
                        checklistRow(text: $item2, isChecked: $isChecked2, index: 1, xOffset: 400, yOffset: -45, checkX: -450, checkY: -40)
                        
                        // سطر 3
                        checklistRow(text: $item3, isChecked: $isChecked3, index: 2, xOffset: 400, yOffset: -10, checkX: -455, checkY: -6)
                        
                        // سطر 4
                        checklistRow(text: $item4, isChecked: $isChecked4, index: 3, xOffset: 420, yOffset: 25, checkX: -445, checkY: 27)
                        
                        // سطر 5
                        checklistRow(text: $item5, isChecked: $isChecked5, index: 4, xOffset: 420, yOffset: 78, checkX: -437, checkY: 68)
                        
                        // سطر 6
                        checklistRow(text: $item6, isChecked: $isChecked6, index: 5, xOffset: 428, yOffset: 110, checkX: -429, checkY: 110)
                    }
                }
            }
        }
        .background(Color.clear)
    }
    
    // دالة مساعدة لإنشاء الأسطر لتقليل تكرار الكود وضمان عمل ميزة اللغة
    @ViewBuilder
    func checklistRow(text: Binding<String>, isChecked: Binding<Bool>, index: Int, xOffset: CGFloat, yOffset: CGFloat, checkX: CGFloat, checkY: CGFloat) -> some View {
        HStack(spacing: 10) {
            TextField("", text: text)
                .focused($focusedIndex, equals: index)
                .textFieldStyle(.plain)
                // هنا ميزة اكتشاف اللغة ليكون الإنجليزي والعربي طبيعي
                .multilineTextAlignment(isArabic(text.wrappedValue) ? .trailing : .leading)
                .strikethrough(isChecked.wrappedValue, color: .black)
                .frame(width: 300)
                .lineLimit(1)
                .onChange(of: text.wrappedValue) { oldValue, newValue in
                    if newValue.count > 30 {
                        text.wrappedValue = String(newValue.prefix(30))
                    }
                }
                .offset(x: xOffset, y: yOffset)
            
            Spacer()
            
            Button {
                isChecked.wrappedValue.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.clear)
                        .frame(width: 45, height: 45)
                    
                    if isChecked.wrappedValue {
                        Image(systemName: "checkmark")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
            }
            .offset(x: checkX, y: checkY)
        }
    }
    
    func isArabic(_ text: String) -> Bool {
        return text.range(of: "\\p{Arabic}", options: .regularExpression) != nil
    }
}

// ✅ جزء المعاينة (Preview)
#Preview {
    ChecklistSheetView()
}
