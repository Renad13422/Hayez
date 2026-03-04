//
//  PrimaryButton.swift
//  Hayez
//
//struct GuidingView: View {
import SwiftUI

struct OnboardingTutorialView: View {
    var onDismiss: () -> Void
    
    @State private var isHiding = false
    
    var body: some View {
        ZStack {
            // خلفية شفافة تغلق عند الضغط
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissTutorial()
                }
            
            // البطاقة
            VStack(spacing: 0) {
                ZStack {
                    // ✅ صورة من الـ Assets
                    Image("page") // ← غير الاسم لاسم الصورة عندك
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 16) {
                        
                        // العنوان
                        Text("These objects are clickable,\nTry one!")
                            .font(.custom("FingerPaint-Regular", size: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                        
                        // الأيقونات
                        HStack(spacing: 24) {
                            TutorialItemView(imageName: "jornal", label: "Journal")
                            TutorialItemView(imageName: "Lamp", label: "Lamp")
                            TutorialItemView(imageName: "chicklist", label: "List")
                        }

                        
                        Divider()
                            .background(Color.white.opacity(0.4))
                            .padding(.horizontal, 20)
                        
                        // تلميح الدارك مود
                        VStack(spacing: 4) {
                            Text("Too bright?")
                                .font(.custom("FingerPaint-Regular", size: 14))
                                .foregroundColor(.white)
                            Text("Tap the window to switch\nto dark mode 🌙")
                                .font(.custom("FingerPaint-Regular", size: 13))
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                        }
                        
                       
                    }
                    .padding(24)
                }
                .frame(width: 300)
            }
            .frame(width: 300)
            .scaleEffect(isHiding ? 0.85 : 1.0)
            .opacity(isHiding ? 0 : 1)
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isHiding)
        }
        .transition(.opacity)
    }
    
    func dismissTutorial() {
        withAnimation(.easeInOut(duration: 0.35)) {
            isHiding = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            onDismiss()
        }
    }
}

// ── عنصر صغير داخل البطاقة ──
struct TutorialItemView: View {
    var imageName: String
    var label: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
            Text(label)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white.opacity(0.9))
                .textCase(.uppercase)
                .tracking(0.5)
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        OnboardingTutorialView(onDismiss: {})
    }
}
