//
//  JournalView.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 13/08/1447 AH.
//
import SwiftUI

struct JournalView: View {
    @Environment(\.dismiss) var dismiss
    
    // استخدام AppStorage لحفظ النص تلقائياً في ذاكرة الجهاز
    @AppStorage("journal_left_page") private var leftPageText: String = ""
    @AppStorage("journal_right_page") private var rightPageText: String = ""
    
    @FocusState private var focusedPage: JournalPage?
    
    enum JournalPage {
        case left, right
    }
    
    var body: some View {
        ZStack {
            // 1. خلفية الجورنال الأصلية من مشروع Hayez
            Image("jornal")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            GeometryReader { geo in
                let w = geo.size.width
                let h = geo.size.height
                
                // --- الصفحة اليسرى ---
                TextEditor(text: $leftPageText)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    // خط عريض وواضح كما طلبتِ
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.black.opacity(0.8))
                    .padding(15)
                    .frame(width: w * 0.38, height: h * 0.60)
                    .focused($focusedPage, equals: .left)
                    // تحديد اتجاه النص (يمين للعربي، يسار للإنجليزي)
                    .multilineTextAlignment(isArabic(leftPageText) ? .trailing : .leading)
                    .onChange(of: leftPageText) { _, newValue in
                        handleOverflow(text: newValue, currentPage: .left)
                    }
                    .position(x: w * 0.31, y: h * 0.48)
                
                // --- الصفحة اليمنى ---
                TextEditor(text: $rightPageText)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.black.opacity(0.8))
                    .padding(15)
                    .frame(width: w * 0.38, height: h * 0.60)
                    .focused($focusedPage, equals: .right)
                    .multilineTextAlignment(isArabic(rightPageText) ? .trailing : .leading)
                    .onChange(of: rightPageText) { _, newValue in
                        handleOverflow(text: newValue, currentPage: .right)
                    }
                    .position(x: w * 0.68, y: h * 0.48)
                
                // زر الرجوع (أعلى اليسار)
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
            // تحديد الصفحة الأولى عند الفتح بناءً على لغة الجهاز
            if Locale.current.language.languageCode?.identifier == "ar" {
                focusedPage = .right
            } else {
                focusedPage = .left
            }
        }
    }
    
    // وظيفة للتعرف على اللغة العربية لتعديل المحاذاة
    func isArabic(_ text: String) -> Bool {
        return text.range(of: "\\p{Arabic}", options: .regularExpression) != nil
    }
    
    // وظيفة الانتقال التلقائي عند امتلاء الصفحة
    func handleOverflow(text: String, currentPage: JournalPage) {
        // يمكنك تعديل هذا الرقم (عدد الحروف) ليتناسب تماماً مع حجم صفحتك
        let maxCharacterLimit = 450
        
        if text.count > maxCharacterLimit {
            withAnimation(.easeInOut) {
                if currentPage == .right && isArabic(text) {
                    focusedPage = .left
                } else if currentPage == .left && !isArabic(text) {
                    focusedPage = .right
                }
            }
        }
    }
}

// ✅ جزء المعاينة (Preview) لمشاهدة النتيجة في Xcode Canvas
#Preview {
    NavigationStack {
        JournalView()
    }
}
