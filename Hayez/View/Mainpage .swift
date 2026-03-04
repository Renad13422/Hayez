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
    @State private var showReflectionPopup = false
    @State private var goToJournalFromTimer = false
    @AppStorage("hasSeenTutorial") private var hasSeenTutorial = false
    @State private var showTutorial = false

    var body: some View {
        NavigationStack {
            ZStack {
                if let character = appState.selectedCharacter {

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

                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .animation(.easeInOut(duration: 0.6), value: isDarkMode)
                        .ignoresSafeArea()
                        .blur(radius: showTutorial ? 10 : 0)
                        .animation(.easeInOut(duration: 0.4), value: showTutorial)

                    GeometryReader { geo in
                        let w = geo.size.width
                        let h = geo.size.height
                        
                        PomodoroTimerView(isWindowDark: isDarkMode) {
                            withAnimation(.spring()) {
                                showReflectionPopup = true
                            }
                        }
                        .frame(width: w * 0.26, height: h * 0.10)
                        .position(x: w * 0.525, y: h * 0.13)

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

                        NavigationLink(destination: JournalView()) {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: w * 0.15, height: h * 0.19)
                        }
                        .position(x: w * 0.16, y: h * 0.8)

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

                if showReflectionPopup {
                    ZStack {
                        Color.black.opacity(0.45)
                            .ignoresSafeArea()
                            .onTapGesture { showReflectionPopup = false }

                        ReflectionPopupView(
                            gender: (appState.selectedCharacter?.gender == .girl) ? "girl" : "boy",
                            isDark: isDarkMode,
                            onYesTap: {
                                showReflectionPopup = false
                                goToJournalFromTimer = true
                            },
                            onNoTap: {
                                withAnimation { showReflectionPopup = false }
                            }
                        )
                    }
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .zIndex(10)
                }

                if showTutorial {
                    OnboardingTutorialView {
                        withAnimation {
                            showTutorial = false
                            hasSeenTutorial = true
                        }
                    }
                    .zIndex(20)
                }
            }
            .navigationDestination(isPresented: $goToJournalFromTimer) {
                JournalView()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeIn(duration: 0.4)) {
                        if !hasSeenTutorial {
                            showTutorial = true
                        }
                    }
                }
            }

        }
    }
}

#Preview {
    let appState = AppStateViewModel()
    appState.selectedCharacter = Character(
        name: "Renad",
        imageName: "girlCard",
        gender: .girl,
        workspaceImage: "maingirl"
    )
    return Mainpage().environmentObject(appState)
}
