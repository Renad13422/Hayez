//
//  CharacterSelectionView.swift
//  Hayez
//
import SwiftUI

struct CharacterSelectionView: View {
    @EnvironmentObject var appState: AppStateViewModel
    @StateObject private var vm = CharacterSelectionViewModel()
    @State private var selectedIndex: Int = 0
    @State private var navigateToChecklist = false

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    // ✅ صورة الخلفية (فيها الزر الأصفر)
                    Image("backCard")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        // ✅ الصورة + النقاط
                        TabView(selection: $selectedIndex) {
                            ForEach(0..<vm.characters.count, id: \.self) { index in
                                let character = vm.characters[index]
                                Image(character.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width * 1.15)
                                    .padding(.top, -29)
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: geo.size.height * 0.9)
                        .padding(.top, geo.size.height * 0.02)
                        .offset(y: -geo.size.height * 0.09)
                        .overlay(alignment: .bottom) {
                            // ✅ النقاط
                            HStack(spacing: 10) {
                                ForEach(0..<vm.characters.count, id: \.self) { i in
                                    Circle()
                                        .fill(i == selectedIndex ? Color.gray : Color.gray.opacity(0.35))
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .padding(.bottom, 38)
                        }

                        Spacer()
                    }
                    
                    // 🔘 الزر مع نص "Select"
                    selectButtonWithText(in: geo.size)
                }
            }
            .navigationDestination(isPresented: $navigateToChecklist) {
                Mainpage()
                    .environmentObject(appState)
            }
            .navigationBarHidden(true)
        }
    }
    
    // 🔘 الزر مع نص "Select"
    private func selectButtonWithText(in size: CGSize) -> some View {
        Button(action: {
            let chosen = vm.characters[selectedIndex]
            appState.selectCharacter(chosen)
            navigateToChecklist = true
        }) {
            ZStack {
                // المستطيل الشفاف (يغطي الزر الأصفر)
                Rectangle()
                    .fill(Color.clear)  // 🔧 للتجربة: Color.red.opacity(0.3)
                    .frame(width: size.width * 0.2, height: size.height * 0.07)
                
                // النص "Select" فوق الزر
                Text("Select")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)  // 🔧 غيّر اللون حسب الخلفية
            }
        }
        .position(
            x: size.width * 0.52,   // 🔧 عدّل الموقع
            y: size.height * 0.95   // 🔧 عدّل الموقع
        )
    }
}

#Preview {
    CharacterSelectionView()
        .environmentObject(AppStateViewModel())
}
