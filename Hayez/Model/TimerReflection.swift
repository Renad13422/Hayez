//
//  TimerSession.swift
//  Hayez
//
//
import SwiftUI

struct ReflectionPopupView: View {
    var gender: String
    var isDark: Bool
    var onYesTap: () -> Void
    var onNoTap: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: -100) {
            
            // 1. ستيكر الشخصية: بيظهر دائماً بنفس الحجم (لايت أو دارك)
            Image(getReflectionImage())
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .zIndex(1)
                .offset(y: -25)

            // 2. فقاعة السؤال
            VStack(alignment: .leading, spacing: 12) {
                Text("Would you like to reflect?")
                    .font(.custom("FingerPaint-Regular", size: 28))
                    // يتغير لون النص فقط للأبيض في الدارك ليكون أوضح
                    .foregroundColor(isDark ? .white : .black)
                
                HStack(spacing: 15) {
                    Button("yes") { onYesTap() }
                        .buttonStyle(ReflectionButtonStyle())
                    
                    Button("no") { onNoTap() }
                        .buttonStyle(ReflectionButtonStyle())
                }
            }
            .padding(.leading, 110)
            .padding(.trailing, 25)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    // ✅ هنا التغيير: نستخدم اللون الكحلي #292B43 في الدارك والبيج في اللايت
                    .fill(isDark ? Color("reflectdark2") : Color(red: 0.9, green: 0.82, blue: 0.61))
                    .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 8)
            )
        }
        .padding()
    }

    // ✅ الدالة المحدثة: تستخدم نفس الستيكرات في الحالتين عشان ما يختفي شي
    func getReflectionImage() -> String {
        // نرجع الستيكر حسب الجنس المختار فقط، بغض النظر عن الدارك مود
        return (gender == "girl") ? "reflectgirl" : "reflectboy"
    }
}

// ستايل الأزرار
struct ReflectionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("FingerPaint-Regular", size: 16))
            .foregroundColor(.black)
            .padding(.horizontal, 22)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.85))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black.opacity(0.8), lineWidth: 1.2))
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
    }
}

// MARK: - البرفيو (Preview)
#Preview("Light Mode") {
    ZStack {
        Color.gray.opacity(0.1).ignoresSafeArea()
        ReflectionPopupView(gender: "boy", isDark: false, onYesTap: {}, onNoTap: {})
    }
}

#Preview("Dark Mode") {
    ZStack {
        Color(red: 0.1, green: 0.1, blue: 0.2).ignoresSafeArea()
        ReflectionPopupView(gender: "girl", isDark: true, onYesTap: {}, onNoTap: {})
    }
}




