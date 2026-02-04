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
    
    var body: some View {
        ZStack {
            if let character = appState.selectedCharacter {
                // منطق اختيار الصورة
                let imageName: String = {
                    if isDarkMode {
                        return character.gender == .girl ? "maingirldark" : "mainboydark"
                    } else {
                        return character.workspaceImage
                    }
                }()
                
                Image(imageName)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
                GeometryReader { geo in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isDarkMode.toggle()
                        }
                    }) {
                        // 1. غيرت اللون هنا عشان تشوف الزر وين مكانه
                        Rectangle()
                            .fill(Color.clear) // غير هذا إلى Color.clear بعد ما تخلص تظبيط
                            // 2. هنا تتحكم بحجم المربع (العرض والارتفاع)
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.4)
                    }
                    // 3. هنا تتحكم بمكان المربع (يمين/يسار وفوق/تحت)
                    .position(
                        x: geo.size.width * 0.04,  // 0.5 يعني بالنص (يمين ويسار)
                        y: geo.size.height * 0.2 // صغرت الرقم عشان يرقا فوق للشباك
                    )
                }
            }
        }
        .ignoresSafeArea()
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

