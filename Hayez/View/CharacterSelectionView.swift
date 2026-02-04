//
//  CharacterSelectionView.swift
//  Hayez
//
import SwiftUI

struct CharacterSelectionView: View {
    @EnvironmentObject var appState: AppStateViewModel
    @StateObject private var vm = CharacterSelectionViewModel()
    @State private var selectedIndex: Int = 0
    @State private var navigateToChecklist = false // ✅ متغير الانتقال

    var body: some View {
        NavigationStack { // ✅ إضافة NavigationStack
            GeometryReader { geo in
                ZStack {
                    // ✅ صورة الخلفية
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
                            .padding(.bottom, 0)
                        }

                        Spacer()

                        // ✅ زر Done
                        HStack {
                            Spacer()
                            Button {
                                let chosen = vm.characters[selectedIndex]
                                appState.selectCharacter(chosen)
                                navigateToChecklist = true // ✅ تفعيل الانتقال
                            } label: {
                                Text("Done")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(
                                        width: geo.size.width * 0.1,
                                        height: 120,
                                        alignment: .leading
                                    )
                                    .padding(.leading, 70)
                                    .background(
                                        Capsule()
                                            .fill(Color(red: 0.21, green: 0.35, blue: 0.49))
                                    )
                                    .shadow(radius: 7, y: 3)
                            }
                            .padding(.trailing, 26)
                            .padding(.bottom, 4)
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToChecklist) {
                ChecklistSheetView() // ✅ الانتقال للصفحة المطلوبة
                    .environmentObject(appState) // ✅ تمرير الـ appState إذا كانت تحتاجه
            }
            .navigationBarHidden(true) // ✅ إخفاء شريط التنقل (اختياري)
        }
    }
}

#Preview {
    CharacterSelectionView()
        .environmentObject(AppStateViewModel())
}
