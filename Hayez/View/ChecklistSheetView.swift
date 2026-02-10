//
//  ChecklistSheetView 3.swift
//  Hayez
//
//


import SwiftUI

struct ChecklistSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    // 🔥 كل واحد له متغير خاص
    @State private var item1 = ""
    @State private var item2 = ""
    @State private var item3 = ""
    @State private var item4 = ""
    @State private var item5 = ""
    @State private var item6 = ""
    
    // 🔥 حالة التشيك لكل مربع
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
                // زر الإغلاق
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
                        // 🔥 1
                        HStack(spacing: 18) {
                            TextField("اكتب هنا..................................................", text: $item1)
                                .focused($focusedIndex, equals: 0)
                                .textFieldStyle(.plain)
                                .strikethrough(isChecked1, color: .black)
                                .strikethrough(isChecked1, color: .black)
                                .frame(width: 300) // 🔥 عرض محدد
                                .lineLimit(1) // 🔥 سطر واحد فقط
                                .onChange(of: item1) { oldValue, newValue in
                                if newValue.count > 40 { // 🔥 حد أقصى 30 حرف
                                item1 = String(newValue.prefix(30))
                                                                    }
                                                                }
                            
                                .offset(x:400, y: -70)
                            
                            Spacer()
                            
                            Button {
                                isChecked1.toggle()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.clear)
                                        .frame(width: 45, height: 45)
                                    
                                    if isChecked1 {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .offset(x:-455, y: -70)
                        }
                        
                        // 🔥 2
                        HStack(spacing: 10) {
                            TextField("اكتب هنا..................................................", text: $item2)
                                .focused($focusedIndex, equals: 1)
                                .textFieldStyle(.plain)
                                .strikethrough(isChecked2, color: .black)
                                .strikethrough(isChecked1, color: .black)
                            .frame(width: 300) // 🔥 عرض محدد
                            .lineLimit(1) // 🔥 سطر واحد فقط
                        .onChange(of: item1) { oldValue, newValue in
                        if newValue.count > 30 { // 🔥 حد أقصى 30 حرف
                    item1 = String(newValue.prefix(30))
                                                                    }
                                                                }
                            
                                .offset(x:400, y: -45)
                            
                            Spacer()
                            
                            Button {
                                isChecked2.toggle()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.clear)
                                        .frame(width: 45, height: 45)
                                    
                                    if isChecked2 {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .offset(x:-450, y: -40)
                        }
                        
                        // 🔥 3
                        HStack(spacing: 10) {
                            TextField("اكتب هنا..................................................", text: $item3)
                                .focused($focusedIndex, equals: 2)
                                .textFieldStyle(.plain)
                                .strikethrough(isChecked3, color: .black)
                                .strikethrough(isChecked1, color: .black)
                                                                .frame(width: 300) // 🔥 عرض محدد
                                                                .lineLimit(1) // 🔥 سطر واحد فقط
                                                                .onChange(of: item1) { oldValue, newValue in
                                                                    if newValue.count > 30 { // 🔥 حد أقصى 30 حرف
                                                                        item1 = String(newValue.prefix(30))
                                                                    }
                                                                }                                .offset(x:400, y: -10)
                            
                            Spacer()
                            
                            Button {
                                isChecked3.toggle()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.clear)
                                        .frame(width: 45, height: 45)
                                    
                                    if isChecked3 {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .offset(x:-455, y: -6)
                        }
                        
                        // 🔥 4
                        HStack(spacing: 10) {
                            TextField("اكتب هنا..................................................", text: $item4)
                                .focused($focusedIndex, equals: 3)
                                .textFieldStyle(.plain)
                                .strikethrough(isChecked4, color: .black)
                                .strikethrough(isChecked1, color: .black)
                                                                .frame(width: 300) // 🔥 عرض محدد
                                                                .lineLimit(1) // 🔥 سطر واحد فقط
                                                                .onChange(of: item1) { oldValue, newValue in
                                                                    if newValue.count > 30 { // 🔥 حد أقصى 30 حرف
                                                                        item1 = String(newValue.prefix(30))
                                                                    }
                                                                }                                .offset(x:420, y: 25)
                            
                            Spacer()
                            
                            Button {
                                isChecked4.toggle()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.clear)
                                        .frame(width: 45, height: 45)
                                    
                                    if isChecked4 {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .offset(x:-445, y: 27)
                        }
                        
                        // 🔥 5
                        HStack(spacing: 10) {
                            TextField("اكتب هنا..................................................", text: $item5)
                                .focused($focusedIndex, equals: 4)
                                .textFieldStyle(.plain)
                                .strikethrough(isChecked5, color: .black)
                                .strikethrough(isChecked1, color: .black)
                                                                .frame(width: 300) // 🔥 عرض محدد
                                                                .lineLimit(1) // 🔥 سطر واحد فقط
                                                                .onChange(of: item1) { oldValue, newValue in
                                                                    if newValue.count > 30 { // 🔥 حد أقصى 30 حرف
                                                                        item1 = String(newValue.prefix(30))
                                                                    }
                                                                }                                .offset(x:420, y: 78)
                            
                            Spacer()
                            
                            Button {
                                isChecked5.toggle()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.clear)
                                        .frame(width: 50, height: 50)
                                    
                                    if isChecked5 {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .offset(x:-437, y: 68)
                        }
                        
                        // 🔥 6
                        HStack(spacing: 10) {
                            TextField("اكتب هنا..................................................", text: $item6)
                                .focused($focusedIndex, equals: 5)
                                .textFieldStyle(.plain)
                                .strikethrough(isChecked6, color: .black)
                                .strikethrough(isChecked1, color: .black)
                                                                .frame(width: 300) // 🔥 عرض محدد
                                                                .lineLimit(1) // 🔥 سطر واحد فقط
                                                                .onChange(of: item1) { oldValue, newValue in
                                                                    if newValue.count > 30 { // 🔥 حد أقصى 30 حرف
                                                                        item1 = String(newValue.prefix(30))
                                                                    }
                                                                }                                .offset(x:428, y: 110)
                            
                            Spacer()
                            
                            Button {
                                isChecked6.toggle()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.clear)
                                        .frame(width: 45, height: 45)
                                    
                                    if isChecked6 {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .offset(x:-429, y: 110)
                        }
                    }
                }
            }
        }
        .background(Color.clear)
    }
}

#Preview {
    ChecklistSheetView()
}
