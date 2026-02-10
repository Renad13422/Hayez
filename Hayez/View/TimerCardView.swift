//
//  TimerCardView.swift
//  Hayez
//
//
import SwiftUI

// MARK: - PomodoroOverlayView
struct PomodoroOverlayView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            isShowing = false
                        }
                    }
                
                VStack(spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(white: 0.05))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )
                            .shadow(color: .black.opacity(0.7), radius: 20)
                        
                        PomodoroTimerView()
                            .padding(10)
                    }
                    .frame(width: w * 0.8, height: h * 0.45)
                }
                .position(x: w * 0.5, y: h * 0.4)
            }
        }
    }
}

// MARK: - PomodoroTimerView
struct PomodoroTimerView: View {
    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    @State private var timeRemaining = 0
    
    @State private var isRunning = false
    @State private var isConfiguring = false
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 15) {
            if isConfiguring {
                // واجهة اختيار الوقت
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        miniPicker(selection: $selectedHours, range: 0..<24)
                            .scaleEffect(1.2)
                        
                        Text(":")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 5)
                        
                        miniPicker(selection: $selectedMinutes, range: 0..<60)
                            .scaleEffect(1.4)
                    }
                    .frame(height: 90)
                    
                    Button {
                        timeRemaining = (selectedHours * 3600) + (selectedMinutes * 60)
                        if timeRemaining > 0 {
                            isConfiguring = false
                            startTimer()
                        }
                    } label: {
                        Text("START")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 6)
                            .background(timeRemaining == 0 && selectedHours == 0 && selectedMinutes == 0 ? Color.gray : Color.green)
                            .clipShape(Capsule())
                    }
                    .padding(.top, -25) // رفع الزر للأعلى
                }
            } else {
                // العرض الرئيسي للتايمر
                Button {
                    if isRunning {
                        stopTimer()
                    } else {
                        isConfiguring = true
                    }
                } label: {
                    VStack(spacing: 6) {
                        // التعديل: إخفاء Tap to Set عند بدء العمل أو وجود وقت متبقي
                        if !isRunning && timeRemaining == 0 {
                            Text("Tap to Set")
                                .font(.system(size: 29, weight: .regular))
                                .foregroundColor(.gray)
                        } else if isRunning {
                            // نص اختياري يظهر أثناء العمل، اتركيه فارغاً لو تبين فقط أرقام
                            Text("Focusing...")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.orange)
                        }
                        
                        Text(timeString)
                            .font(.system(size: 44, weight: .light, design: .monospaced))
                            .foregroundColor(.white)
                            .monospacedDigit()
                    }
                }
            }
        }
    }
    
    func miniPicker(selection: Binding<Int>, range: Range<Int>) -> some View {
        Picker("", selection: selection) {
            ForEach(range, id: \.self) { i in
                Text(String(format: "%02d", i))
                    .font(.system(size: 20))
                    .tag(i)
                    .foregroundColor(.white)
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 70, height: 90)
        .clipped()
    }

    var timeString: String {
        let h = timeRemaining / 3600
        let m = (timeRemaining % 3600) / 60
        let s = timeRemaining % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }

    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        PomodoroOverlayView(isShowing: .constant(true))
    }
}
