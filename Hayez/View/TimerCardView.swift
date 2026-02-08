//
//  TimerCardView.swift
//  Hayez
//
//

import SwiftUI

struct PomodoroTimerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var workMinutes = 45
    @State private var breakMinutes = 5
    @State private var selectedMinutes = 45
    @State private var selectedSeconds = 0
    @State private var timerMode: TimerMode = .work
    @State private var isRunning = false
    @State private var timeRemaining = 2700 // 45 دقيقة
    @State private var timer: Timer?
    @State private var completedSessions = 0
    
    enum TimerMode: String {
        case work = "Work"
        case break_ = "Break"
        
        var color: Color {
            switch self {
            case .work: return .red
            case .break_: return .green
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // العنوان
                HStack {
                    Button("Cancel") {
                        stopTimer()
                        dismiss()
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 60)
                }
                .padding()
                
       
                
                // عداد الجلسات المكتملة
                Text("Completed Sessions: \(completedSessions)")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .padding(.top, 10)
                
                Spacer()
                
                // العرض الرئيسي للوقت
                if !isRunning {
                    VStack(spacing: 20) {
                        // اختيار وقت العمل
                        VStack {
                            Text("Work Duration")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            
                            HStack(spacing: 0) {
                                Picker("Work Minutes", selection: $workMinutes) {
                                    ForEach(1..<121) { i in
                                        Text("\(i)").tag(i)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: 100)
                                
                                Text("min")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // اختيار وقت الراحة
                        VStack {
                            Text("Break Duration")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            
                            HStack(spacing: 0) {
                                Picker("Break Minutes", selection: $breakMinutes) {
                                    ForEach(1..<61) { i in
                                        Text("\(i)").tag(i)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: 100)
                                
                                Text("min")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                } else {
                    // عرض العد التنازلي
                    VStack(spacing: 10) {
                        Text(timerMode.rawValue)
                            .font(.title3)
                            .foregroundColor(.gray)
                        
                        Text(timeString)
                            .font(.system(size: 80, weight: .thin, design: .rounded))
                            .foregroundColor(timerMode.color)
                            .monospacedDigit()
                    }
                }
                
                Spacer()
                
                // أزرار التحكم
                HStack(spacing: 60) {
                    // زر Reset
                    Button {
                        stopTimer()
                        if timerMode == .work {
                            timeRemaining = workMinutes * 60
                            selectedMinutes = workMinutes
                        } else {
                            timeRemaining = breakMinutes * 60
                            selectedMinutes = breakMinutes
                        }
                    } label: {
                        Text("Reset")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .frame(width: 100, height: 100)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    // زر Start/Pause
                    Button {
                        if isRunning {
                            pauseTimer()
                        } else {
                            startTimer()
                        }
                    } label: {
                        Text(isRunning ? "Pause" : "Start")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .background(isRunning ? Color.orange : Color.green)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            timeRemaining = workMinutes * 60
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        if !isRunning {
            if timerMode == .work {
                timeRemaining = workMinutes * 60
            } else {
                timeRemaining = breakMinutes * 60
            }
        }
        
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timerCompleted()
            }
        }
    }
    
    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func stopTimer() {
        pauseTimer()
        isRunning = false
    }
    
    func timerCompleted() {
        stopTimer()
        
        // تحديث العداد والوضع
        if timerMode == .work {
            completedSessions += 1
            timerMode = .break_
            timeRemaining = breakMinutes * 60
        } else {
            timerMode = .work
            timeRemaining = workMinutes * 60
        }
        
        // يمكن إضافة صوت أو اهتزاز هنا
    }
}

#Preview {
    PomodoroTimerView()
}
