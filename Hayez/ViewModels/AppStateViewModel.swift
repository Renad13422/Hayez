//
//  AppStateViewModel.swift
//  Hayez
//
//  Created by RENAD MAJED ALSHAHRANY  on 13/08/1447 AH.
//


import SwiftUI
import Combine

class AppStateViewModel: ObservableObject {
    // هذا المتغير هو المسؤول عن التنقل بين الصفحات في AppRootView
    @Published var isCharacterChosen: Bool = false
    
    // لتخزين بيانات الشخصية التي اختارها المستخدم
    @Published var selectedCharacter: Character?

    // الدالة التي يتم استدعاؤها من صفحة CharacterSelectionView
    func selectCharacter(_ character: Character) {
        // 1. تخزين الشخصية المختارة
        self.selectedCharacter = character
        
        // 2. تغيير الحالة لـ true لتبديل الواجهة فوراً
        withAnimation {
            self.isCharacterChosen = true
        }
        
        print("تم اختيار الشخصية: \(character.imageName)")
    }
    
    // دالة اختيارية إذا أردت العودة لصفحة الاختيار لاحقاً
    func resetSelection() {
        self.isCharacterChosen = false
        self.selectedCharacter = nil
    }
}
