//
//  ChecklistSheetView 3.swift
//  Hayez
//
//

import SwiftUI

struct ChecklistSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("item1") private var item1 = ""
        @AppStorage("item2") private var item2 = ""
        @AppStorage("item3") private var item3 = ""
        @AppStorage("item4") private var item4 = ""
        @AppStorage("item5") private var item5 = ""
        @AppStorage("item6") private var item6 = ""
        
        @AppStorage("isChecked1") private var isChecked1 = false
        @AppStorage("isChecked2") private var isChecked2 = false
        @AppStorage("isChecked3") private var isChecked3 = false
        @AppStorage("isChecked4") private var isChecked4 = false
        @AppStorage("isChecked5") private var isChecked5 = false
        @AppStorage("isChecked6") private var isChecked6 = false
        
    
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
                        // 1
                        HStack(spacing: 18) {
                            TextField("write here...", text: $item1)
                                .focused($focusedIndex, equals: 0)
                                .textFieldStyle(.plain)
                                .font(.system(size:24,weight:.medium))
                                .strikethrough(isChecked1, color: .black)
                                .frame(width: 320)
                                .multilineTextAlignment(.trailing)                                .lineLimit(1)
                                .onChange(of: item1) { oldValue, newValue in
                                    if newValue.count > 17 {
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
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .offset(x:-500, y: -70)
                        }
                        
                        // 2
                        HStack(spacing: 10) {
                            TextField("", text: $item2)
                                .focused($focusedIndex, equals: 1)
                                .textFieldStyle(.plain)
                                .font(.system(size:24,weight:.medium))                                .strikethrough(isChecked2, color: .black)
                                .frame(width: 320)
                                .multilineTextAlignment(.trailing)                                  .lineLimit(1)
                                .onChange(of: item2) { oldValue, newValue in
                                    if newValue.count > 17 {
                                        item2 = String(newValue.prefix(30))
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
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .offset(x:-495, y: -40)
                        }
                        
                        // 3
                        HStack(spacing: 10) {
                            TextField("", text: $item3)
                                .focused($focusedIndex, equals: 2)
                                .textFieldStyle(.plain)
                                .font(.system(size:24,weight:.medium))                                .strikethrough(isChecked3, color: .black)
                                .frame(width: 320)
                                .multilineTextAlignment(.trailing)                                  .lineLimit(1)
                                .onChange(of: item3) { oldValue, newValue in
                                    if newValue.count > 17 {
                                        item3 = String(newValue.prefix(30))
                                    }
                                }
                                .offset(x:400, y: -10)
                            
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
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .offset(x:-490, y: -6)
                        }
                        
                        // 4
                        HStack(spacing: 10) {
                            TextField("", text: $item4)
                                .focused($focusedIndex, equals: 3)
                                .textFieldStyle(.plain)
                                .font(.system(size:24,weight:.medium))                                .strikethrough(isChecked4, color: .black)
                                .frame(width: 320)
                                .multilineTextAlignment(.trailing)                                  .lineLimit(1)
                                .onChange(of: item4) { oldValue, newValue in
                                    if newValue.count > 17 {
                                        item4 = String(newValue.prefix(30))
                                    }
                                }
                                .offset(x:420, y: 25)
                            
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
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .offset(x:-480, y: 27)
                        }
                        
                        // 5
                        HStack(spacing: 10) {
                            TextField("", text: $item5)
                                .focused($focusedIndex, equals: 4)
                                .textFieldStyle(.plain)
                                .font(.system(size:24,weight:.medium))                                .strikethrough(isChecked5, color: .black)
                                .frame(width: 320)
                                .multilineTextAlignment(.trailing)                                  .lineLimit(1)
                                .onChange(of: item5) { oldValue, newValue in
                                    if newValue.count > 17 {
                                        item5 = String(newValue.prefix(30))
                                    }
                                }
                                .offset(x:420, y: 78)
                            
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
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .offset(x:-471, y: 68)
                        }
                        
                        // 6
                        HStack(spacing: 10) {
                            TextField("", text: $item6)
                                .focused($focusedIndex, equals: 5)
                                .textFieldStyle(.plain)
                                .font(.system(size:24,weight:.medium))                                .strikethrough(isChecked6, color: .black)
                                .frame(width: 320)
                                .multilineTextAlignment(.trailing)                                  .lineLimit(1)
                                .onChange(of: item6) { oldValue, newValue in
                                    if newValue.count > 17 {
                                        item6 = String(newValue.prefix(30))
                                    }
                                }
                                .offset(x:428, y: 110)
                            
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
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .offset(x:-465, y: 110)
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
