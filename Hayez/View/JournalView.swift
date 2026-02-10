//
//  JournalView.swift
//  Hayez
//
//
import SwiftUI
import AVFoundation

struct JournalView: View {
    @Environment(\.dismiss) var dismiss
    
    // حفظ النص الأساسي في ذاكرة الجهاز
    @AppStorage("journal_main_text") private var mainText: String = ""
    // متغير لتخزين النص السابق بصرياً في الصفحة اليمنى
    @State private var previousPageText: String = ""
    
    @FocusState private var isFocused: Bool
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            // خلفية الجورنال الأصلية من مشروع Hayez
            Image("jornal")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            GeometryReader { geo in
                let w = geo.size.width
                let h = geo.size.height
                
                // --- الصفحة اليسرى: هي الوحيدة المخصصة للكتابة الآن ---
                TextEditor(text: $mainText)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(.black.opacity(0.8))
                    .padding(15)
                    .frame(width: w * 0.30, height: h * 0.60)
                    .focused($isFocused)
                    .multilineTextAlignment(isArabic(mainText) ? .trailing : .leading)
                    .onChange(of: mainText) { _, newValue in
                        handlePageFlip(text: newValue)
                    }
                    .position(x: w * 0.31, y: h * 0.48)
                
                // --- الصفحة اليمنى: تظهر فيها الصفحة "الممسوحة" لإعطاء إيحاء الورقة المقلوبة ---
                Text(previousPageText)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.black.opacity(0.3)) // لون باهت كأنه حبر قديم
                    .padding(15)
                    .frame(width: w * 0.38, height: h * 0.60, alignment: .topLeading)
                    .multilineTextAlignment(isArabic(previousPageText) ? .trailing : .leading)
                    .position(x: w * 0.68, y: h * 0.48)
                
                // زر الرجوع
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.brown)
                        .background(Color.white.clipShape(Circle()))
                }
                .position(x: 60, y: 60)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            setupAudio()
            isFocused = true
        }
    }
    
    // وظيفة معالجة امتلاء الصفحة عند وصول 100 كلمة
    func handlePageFlip(text: String) {
        let words = text.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        
        if words.count >= 100 {
            // 1. تشغيل صوت قلب الورقة
            playFlipSound()
            
            // 2. تفعيل اهتزاز خفيف (Haptic Feedback)
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            // 3. مسح الصفحة اليسرى ونقل النص لليمين
            withAnimation(.easeInOut(duration: 0.8)) {
                previousPageText = mainText
                mainText = ""
            }
        }
    }
    
    func isArabic(_ text: String) -> Bool {
        return text.range(of: "\\p{Arabic}", options: .regularExpression) != nil
    }
    
    func setupAudio() {
        if let soundURL = Bundle.main.url(forResource: "page-flip", withExtension: "mp3") {
            audioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
        }
    }
    
    func playFlipSound() {
        audioPlayer?.play()
    }
}

// ✅ جزء المعاينة (Preview) لمشاهدة النتيجة في Xcode
#Preview {
    NavigationStack {
        JournalView()
    }
}
