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
    @State private var showReflectionPopup = false // للتحكم في ظهور بوب أب الرفليكت
    @State private var goToJournalFromTimer = false // للتحكم في الانتقال للجورنال

    var body: some View {
        NavigationStack {
            ZStack {
                if let character = appState.selectedCharacter {

                    // 1. منطق الصور (تتغير حسب الشخصية والوضع واللمبة)
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

                    // 2. الخلفية الأساسية (التي تتفاعل مع الزووم والأنميشن)
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .animation(.easeInOut(duration: 0.6), value: isDarkMode)
                        .ignoresSafeArea()

                    // 3. طبقة العناصر التفاعلية باستخدام GeometryReader
                    GeometryReader { geo in
                        let w = geo.size.width
                        let h = geo.size.height
                        
                        // ✅ التايمر: عند الانتهاء يُظهر بوب أب الرفليكت
                        PomodoroTimerView(isWindowDark: isDarkMode) {
                            withAnimation(.spring()) {
                                showReflectionPopup = true
                            }
                        }
                        .frame(width: w * 0.26, height: h * 0.10)
                        .position(x: w * 0.525, y: h * 0.13)

                        // زر الرجوع لشاشة اختيار الشخصية
                        Button {
                            appState.resetSelection()
                        } label: {
                            Circle()
                                .fill(Color.white.opacity(0.9))
                                .frame(width: w * 0.03, height: w * 0.02)
                                .overlay(
                                    Image(systemName: "chevron.backward.circle.fill")
                                        .font(.system(size: 35, weight: .semibold))
                                        .foregroundColor(.black.opacity(0.4))
                                )
                        }
                        .position(x: w * 0.92, y: h * 0.11)

                        // زر الشباك (Toggle Dark Mode)
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

                        // زر المصباح (يعمل فقط في الوضع المظلم)
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

                        // الجورنال الأحمر (دخول يدوي عند الضغط عليه في الرسمة)
                        NavigationLink(destination: JournalView()) {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: w * 0.15, height: h * 0.19)
                        }
                        .position(x: w * 0.16, y: h * 0.8)

                        // الدفتر الأبيض (Checklist)
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
                }
                
                // ✅ طبقة قائمة المهام (Checklist)
                if showChecklistSheet {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation { showChecklistSheet = false }
                            }
                        ChecklistSheetView()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(5)
                }

                // ✅ بوب أب الرفليكت المخصص (يظهر عند انتهاء التايمر)
                if showReflectionPopup {
                    ZStack {
                        Color.black.opacity(0.45)
                            .ignoresSafeArea()
                            .onTapGesture { showReflectionPopup = false }

                        // استدعاء ملف الـ ReflectionPopupView الذي أنشأناه
                        ReflectionPopupView(
                            gender: (appState.selectedCharacter?.gender == .girl) ? "girl" : "boy",
                            isDark: isDarkMode,
                            onYesTap: {
                                // إغلاق البوب أب وتفعيل الانتقال للجورنال
                                showReflectionPopup = false
                                goToJournalFromTimer = true
                            },
                            onNoTap: {
                                withAnimation { showReflectionPopup = false }
                            }
                        )
                    }
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .zIndex(10) // لضمان ظهوره فوق كل شيء
                }
            }
            // الربط البرمجي للانتقال لصفحة الجورنال
            .navigationDestination(isPresented: $goToJournalFromTimer) {
                JournalView()
            }
        }
    }
}

#Preview {
    let appState = AppStateViewModel()
    // تجربة البرفيو بشخصية بنت (ريناد)
    appState.selectedCharacter = Character(
        name: "Renad",
        imageName: "girlCard",
        gender: .girl,
        workspaceImage: "maingirl"
    )
    return Mainpage().environmentObject(appState)
}
