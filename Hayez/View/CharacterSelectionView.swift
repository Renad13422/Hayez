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
                    // 1. الخلفية (كاملة بدون قص)
                    Image("backCard")
                        .resizable()
                        .ignoresSafeArea()
                        .frame(width: geo.size.width, height: geo.size.height)

                    // 2. المحتوى (الصور والنقاط)
                    VStack(spacing: 0) {
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
                            // النقاط
                            HStack(spacing: 10) {
                                ForEach(0..<vm.characters.count, id: \.self) { i in
                                    Circle()
                                        // ✅ هنا نستخدم اسم اللون "point" الذي أنشأته
                                        .fill(i == selectedIndex ? Color("point") : Color("point").opacity(0.35))
                                        .frame(width: 16, height: 16)
                                }
                            }

                            .padding(.bottom, 30)
                        }
                        
                        Spacer()
                    }

                    // 3. الزر (buttony)
                    VStack {
                        Spacer()
                        
                        Button {
                            let chosen = vm.characters[selectedIndex]
                            appState.selectCharacter(chosen)
                            navigateToChecklist = true
                        } label: {
                            ZStack {
                                Image("buttony")
                                    .resizable()
                                    // 👇 مقاسات التصميم
                                    .frame(width: 231, height: 53)
                                
                                Text("Select")
                                    .font(.custom("FingerPaint-Regular", size: 36))
                                    .foregroundColor(.black)
                                    .padding(.bottom, 4)
                            }
                        }
                        // 👇👇👇 هنا السطر اللي يرفع الزر فوق
                        .padding(.bottom, 10)
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToChecklist) {
                Mainpage()
                    .environmentObject(appState)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    CharacterSelectionView()
        .environmentObject(AppStateViewModel())
}

