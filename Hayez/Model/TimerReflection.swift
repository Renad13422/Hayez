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
        // تقليل الـ spacing السالب يخلي الستيكر يدخل أكثر
        HStack(alignment: .center, spacing: -100) {
            
            // ستيكر الشخصية
            Image(getReflectionImage())
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .zIndex(1)
                .offset(y: -25)

            // فقاعة السؤال
            VStack(alignment: .leading, spacing: 12) {
                Text("Would you like to reflect?")
                    // استخدام الخط المخصص FingerPaint
                    .font(.custom("FingerPaint-Regular", size: 28))
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: 15) {
                    Button("yes") { onYesTap() }
                        .buttonStyle(ReflectionButtonStyle())
                    
                    Button("no") { onNoTap() }
                        .buttonStyle(ReflectionButtonStyle())
                }
            }
            // تقليل الـ leading padding يخلي النص يتوسع جهة الستيكر
            .padding(.leading, 150)
            .padding(.trailing, 25)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color(red: 0.9, green: 0.82, blue: 0.61))
                    .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 8)
            )
        }
        .padding()
    }
    
    func getReflectionImage() -> String {
        if isDark { return "reflectdark" }
        return (gender == "girl") ? "reflectgirl" : "reflectboy"
    }
}

// ستايل الأزرار مع الخط المخصص
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

#Preview {
    ZStack {
        Color.gray.opacity(0.2).ignoresSafeArea()
        ReflectionPopupView(gender: "boy", isDark: false, onYesTap: {}, onNoTap: {})
    }
}





