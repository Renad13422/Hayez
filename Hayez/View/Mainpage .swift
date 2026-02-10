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
                                .fill(Color.clear)
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
                                .fill(Color.clear)
                                .frame(width: w * 0.1, height: h * 0.25)
                        }
                        .position(x: w * 0.08, y: h * 0.55)

                        // ج- الجورنال الأحمر
                        NavigationLink {
                            JournalView()
                        } label: {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: w * 0.15, height: h * 0.19)
                        }
                        .position(x: w * 0.16, y: h * 0.8)

                        // د- الدفتر الأبيض (Checklist)
                        Button {
                            withAnimation { showChecklistSheet.toggle() }
                        } label: {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: w * 0.1, height: h * 0.15)
                        }
                        .position(x: w * 0.78, y: h * 0.60)
                    }
                    .scaleEffect(isDarkMode ? 1.08 : 1.0)
                    .animation(.easeInOut(duration: 0.6), value: isDarkMode)
                    
                    // 🔥🔥 الدفتر ينزل من فوق - كبير وبدون خلفية بيضاء
                    if showChecklistSheet {
                        ZStack {
                            // خلفية شفافة سوداء للضغط عليها وإغلاق الصورة
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    withAnimation { showChecklistSheet = false }
                                }
                            
                            VStack(spacing: 0) {
                                // زر الإغلاق
                                HStack {
                                    Spacer()
                                    Button {
                                        withAnimation { showChecklistSheet = false }
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)
                                            .shadow(radius: 5)
                                            .padding()
                                    }
                                }
                                
                                Spacer()
                                
                                // 🔥🔥 صورة الدفتر - كبيرة مره بدون خلفية بيضاء
                                Image("chicklist")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 1.15) // 🔥 90% من عرض الشاشة
                                    // 💡 لتكبيرها أكثر، غيّر 0.9 لـ 0.95 أو 1.0
                                
                                Spacer()
                            }
                        }
                        .transition(.move(edge: .top).combined(with: .opacity))
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
