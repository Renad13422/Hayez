//
//  Mainpage .swift
//  Hayez
//
//  Created by ريناد محمد حملي on 16/08/1447 AH.
//

import SwiftUI

struct Mainpage: View {
    @EnvironmentObject var appState: AppStateViewModel

    @State private var isDarkMode = false
    @State private var isLampOn = false
    @State private var showChecklistSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                if let character = appState.selectedCharacter {

                    // 1. تحديد الصور بناءً على الحالة والشخصية
                    let baseImage = character.workspaceImage
                    let darkImage = (character.gender == .girl) ? "maingirldark" : "mainboydark"
                    let lightImage = (character.gender == .girl) ? "lightgirl" : "lightboy"

                    let imageName: String = {
                        if isDarkMode {
                            return isLampOn ? lightImage : darkImage
                        } else {
                            return baseImage
                        }
                    }()

                    // 2. الخلفية مع تأثير الزووم
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(isDarkMode ? 1.01 : 1.0) // زووم 8% عند تفعيل الدارك مود
                        .animation(.easeInOut(duration: 0.6), value: isDarkMode)
                        .ignoresSafeArea()

                    // 3. طبقة أزرار الضغط (GeometryReader)
                    GeometryReader { geo in
                        let w = geo.size.width
                        let h = geo.size.height

                        // أ- زر الشباك (تبديل الوضع)
                        Button {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                isDarkMode.toggle()
                                if !isDarkMode { isLampOn = false }
                            }
                        } label: {
                            Rectangle()
                                .fill(Color.red.opacity(0.2)) // 👈 غيره لـ .clear بعد ضبط المقاس
                                .frame(width: w * 0.15, height: h * 0.90)
                        }
                        .position(x: w * 0.08, y: h * 0.0)

                        // ب- زر المصباح (يشتغل فقط في الدارك مود)
                        Button {
                            if isDarkMode {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    isLampOn.toggle()
                                }
                            }
                        } label: {
                            Rectangle()
                                .fill(Color.blue.opacity(0.2)) // 👈 غيره لـ .clear لاحقاً
                                .frame(width: w * 0.1, height: h * 0.25)
                        }
                        .position(x: w * 0.08, y: h * 0.55)

                        // ج- الجورنال الأحمر
                        NavigationLink {
                            JournalView()
                        } label: {
                            Rectangle()
                                .fill(Color.green.opacity(0.2)) // 👈 غيره لـ .clear لاحقاً
                                .frame(width: w * 0.15, height: h * 0.19)
                        }
                        .position(x: w * 0.16, y: h * 0.8)

                        // د- الدفتر الأبيض (Checklist)
                        Button {
                            withAnimation { showChecklistSheet.toggle() }
                        } label: {
                            Rectangle()
                                .fill(Color.yellow.opacity(0.9)) // 👈 غيره لـ .clear لاحقاً
                                .frame(width: w * 0.1, height: h * 0.15)
                        }
                        .position(x: w * 0.78, y: h * 0.60)
                    }
                    // نجعل الأزرار تتحرك مع الزووم لتبقى في مكانها الصحيح فوق الرسمة
                    .scaleEffect(isDarkMode ? 1.08 : 1.0)
                    .animation(.easeInOut(duration: 0.6), value: isDarkMode)
                    
                    // 👇 الدفتر ينزل من فوق (بدل الشيت)
                    if showChecklistSheet {
                        VStack(spacing: 0) {
                            Text("الدفتر")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white) // 👈 أضف هذا السطر
                                .padding()

                            HStack {
                                Spacer()
                                Button {
                                    withAnimation { showChecklistSheet = false }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.gray)
                                        .padding()
                                }
                            }
                            .background(Color.green)
                            
                            Image("chicklist")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 400, maxHeight: 500)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(radius: 20)
                            
                            Spacer()
                        }
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .background(
                            Color.black.opacity(0.3)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    withAnimation { showChecklistSheet = false }
                                }
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    let appState = AppStateViewModel()
    appState.selectedCharacter = Character(
        name: "Osama",
        imageName: "girlCard",
        gender: .girl,
        workspaceImage: "maingirl"
    )
    return Mainpage().environmentObject(appState)
}

