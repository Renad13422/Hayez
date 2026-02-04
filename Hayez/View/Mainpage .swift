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

    var body: some View {
        NavigationStack {
            ZStack {
                if let character = appState.selectedCharacter {

                    // ✅ الصور حسب اختيار الشخصية
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
                        .ignoresSafeArea()

                    GeometryReader { geo in

                        // ✅ (1) الشباك: Dark/Normal
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isDarkMode.toggle()
                                if !isDarkMode { isLampOn = false }
                            }
                        } label: {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: geo.size.width * 0.18,
                                       height: geo.size.height * 0.55)
                        }
                        .position(x: geo.size.width * 0.06,
                                  y: geo.size.height * 0.15)

                        // ✅ (2) المصباح: يشتغل فقط إذا صار ظلام
                        Button {
                            guard isDarkMode else { return }
                            withAnimation(.easeInOut(duration: 0.25)) {
                                isLampOn.toggle()
                            }
                        } label: {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: geo.size.width * 0.10,
                                       height: geo.size.height * 0.25)
                        }
                        .position(x: geo.size.width * 0.07,
                                  y: geo.size.height * 0.57)

                        // ✅ (3) الجورنال الأحمر: يروح لصفحة الجورنال
                        NavigationLink {
                            JournalView()

                        } label: {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: geo.size.width * 0.14,
                                       height: geo.size.height * 0.16)
                        }
                        .position(x: geo.size.width * 0.17,
                                  y: geo.size.height * 0.78)

                        // ✅ (4) الدفتر الأبيض الصغير: يطلع Sheet للتشك لست
                        Button {
                            showChecklistSheet = true
                        } label: {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: geo.size.width * 0.06,
                                       height: geo.size.height * 0.09)
                        }
                        .position(x: geo.size.width * 0.77,
                                  y: geo.size.height * 0.57)

                        // 🔧 لو تبين تشوفين مربعات الضغط:
                        // بدلي Color.clear إلى Color.red.opacity(0.25) مؤقتًا
                    }
                }
            }
            .sheet(isPresented: $showChecklistSheet) {
                ChecklistSheetView()
                    .presentationDetents([.large])          // ✅ كبير ويبدأ من تحت
                    .presentationContentInteraction(.scrolls)
                    .presentationDragIndicator(.visible)    // ✅ خط السحب
            }

            }

                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
                    .presentationBackground(.white)   // ✅ يخلي خلفية الشيت بيضاء فعلًا
            }

            }

            
        
    


#Preview {
    let appState = AppStateViewModel()
    appState.selectedCharacter = Character(
        name: "Girl",
        imageName: "girlCard",
        gender: .girl,
        workspaceImage: "maingirl"
    )
    return Mainpage().environmentObject(appState)
}
