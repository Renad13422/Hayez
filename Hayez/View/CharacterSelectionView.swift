//
//  CharacterSelectionView.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 13/08/1447 AH.
//

import SwiftUI

struct CharacterSelectionView: View {
    @EnvironmentObject var appState: AppStateViewModel
    @StateObject private var vm = CharacterSelectionViewModel()

    @State private var selectedIndex: Int = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("background")
                    .ignoresSafeArea()

                VStack(spacing: 0) {

                    // ✅ الصورة + النقاط "ملصوقة" تحت الصورة (Overlay)
                    TabView(selection: $selectedIndex) {
                        ForEach(Array(vm.characters.enumerated()), id: \.offset) { index, character in
                            Image(character.imageName)
                                .resizable()
                                .scaledToFit() // ✅ يحافظ على كامل الصورة
                                .frame(width: geo.size.width * 0.92) // ✅ يكبرها
                                .padding(.top, -29) // ✅ يرفعها
                                .tag(index)

                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: geo.size.height * 0.78)
    // منطقة الصورة أكبر
                    .padding(.top, geo.size.height * 0.02)     // رفعها لفوق
                    .offset(y: -geo.size.height * 0.09)        // رفع إضافي
                    .overlay(alignment: .bottom) {
                        // ✅ النقاط هنا بالضبط تحت الصورة
                        HStack(spacing: 10) {
                            ForEach(0..<vm.characters.count, id: \.self) { i in
                                Circle()
                                    .fill(i == selectedIndex ? Color.gray : Color.gray.opacity(0.35))
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .padding(.bottom, 10) // قربها من أسفل الفريم الأزرق
                    }

                    Spacer()

                    // ✅ زر Done يمين + نص
                    HStack {
                        Spacer()
                        Button {
                            let chosen = vm.characters[selectedIndex]
                            appState.selectCharacter(chosen)
                        } label: {
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(
                                    width: geo.size.width * 0.42,
                                    height: 52,
                                    alignment: .leading
                                )
                                .padding(.leading, 24)

                                .background(
                                    Capsule()
                                        .fill(Color(red: 0.21, green: 0.35, blue: 0.49))
                                )
                                .shadow(radius: 7, y: 3)
                        }
                        .padding(.trailing, -60)
                        .padding(.bottom, 70)
                    }
                }
            }
        }
    }
}


#Preview {
    CharacterSelectionView()
        .environmentObject(AppStateViewModel())
}

