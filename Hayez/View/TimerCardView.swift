//
//  TimerCardView.swift
//  Hayez
//
import SwiftUI

struct PomodoroTimerView: View {
    var isWindowDark: Bool = false
    
    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    @State private var timeRemaining = 0
    @State private var isRunning = false
    @State private var isConfiguring = false
    @State private var timer: Timer?
    
    private var dynamicColor: Color {
        isWindowDark ? .black : .white
    }
    
    var body: some View {
        VStack(spacing: 15) {
            if isConfiguring {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        miniPicker(selection: $selectedHours, range: 0..<24)
                            .scaleEffect(1.2)
                        Text(":")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(dynamicColor)
                            .padding(.horizontal, 5)
                        miniPicker(selection: $selectedMinutes, range: 0..<60)
                            .scaleEffect(1.4)
                    }
                    .frame(height: 90)
                    
                    Button {
                        let totalSeconds = (selectedHours * 3600) + (selectedMinutes * 60)
                        if totalSeconds > 0 {
                            timeRemaining = totalSeconds
                            isConfiguring = false
                            startTimer()
                        }
                    } label: {
                        Text("START")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(isWindowDark ? .white : .black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 6)
                            // ✅ هنا التعديل: رمادي إذا الوقت صفر، وأخضر إذا تم التحديد
                            .background((selectedHours == 0 && selectedMinutes == 0) ? Color.gray : Color.green)
                            .clipShape(Capsule())
                    }
                    .padding(.top, -25)
                }
            } else {
                Button {
                    if isRunning { stopTimer() } else { isConfiguring = true }
                } label: {
                    VStack(spacing: 6) {
                        if !isRunning && timeRemaining == 0 {
                            Text("Tap to Set")
                                .font(.system(size: 29, weight: .regular))
                                .foregroundColor(dynamicColor.opacity(0.6))
                        } else if isRunning {
                            Text("Focusing...")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.orange)
                        }
                        Text(timeString)
                            .font(.system(size: 44, weight: .light, design: .monospaced))
                            .foregroundColor(dynamicColor)
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
                    .foregroundColor(dynamicColor)
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
            if timeRemaining > 0 { timeRemaining -= 1 } else { stopTimer() }
        }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
}

// ✅ الكانفس لمشاهدة تغيير لون الزر عند التحريك
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PomodoroTimerView(isWindowDark: false)
    }
}


