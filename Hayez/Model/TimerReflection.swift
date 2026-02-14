//
//  TimerSession.swift
//  Hayez
//
//
import SwiftUI

struct ReflectionPopupView: View {
    // 1. الخصائص الأساسية
    var gender: String
    var isDark: Bool
    
    // 2. الأكشات لربطها بالصفحة الرئيسية (Mainpage)
    var onYesTap: () -> Void
    var onNoTap: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            
            // اختيار الصورة بناءً على حالة المود والجنس
            Image(getReflectionImage())
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .offset(y: -25) // الحركة اللي تخلي الرأس يبرز فوق الفقاعة كما في تصميمك

            // فقاعة السؤال (التصميم المستوحى من سكتش)
            VStack(alignment: .leading, spacing: 15) {
                Text("Would you like to reflect?")
                    .font(.system(size: 50, weight: .medium, design: .rounded))
                    .foregroundColor(.black)
                
                HStack(spacing: 15) {
                    // زر الموافقة
                    Button(action: {
                        onYesTap()
                    }) {
                        Text("yes")
                    }
                    .buttonStyle(ReflectionButtonStyle())
                    
                    // زر الرفض
                    Button(action: {
                        onNoTap()
                    }) {
                        Text("no")
                    }
                    .buttonStyle(ReflectionButtonStyle())
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.9, green: 0.82, blue: 0.61)) // لون بيج (Paper Effect)
                    .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
            )
        }
        .padding()
    }
    
    // منطق اختيار صورة الستيكر من الأصول (Assets)
    func getReflectionImage() -> String {
        if isDark {
            return "reflectdark"
        }
        return (gender == "girl") ? "reflectgirl" : "reflectboy"
    }
}

// ستايل الأزرار الموحد (Custom Button Style)
struct ReflectionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.black)
            .padding(.horizontal, 22)
            .padding(.vertical, 7)
            .background(Color.white.opacity(0.8))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0) // أنميشن ضغط خفيف
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

// البرفيو للتأكد من الشكل (ولد + نهار)
#Preview {
    ZStack {
        Color.gray.opacity(0.3).ignoresSafeArea()
        ReflectionPopupView(gender: "boy", isDark: false, onYesTap: {}, onNoTap: {})
    }
}
