//
//  ChipsView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import SwiftUI


struct ChipsView: View {
    
    @Binding private var getSelectedChips: Set<String>
    @Binding private var getExpandable: Bool
    private var getChipList: [String]
    private var getOnClick: (Set<String>) -> ()
    
    init(
        setChipList: [String],
        getSelectedChips: Binding<Set<String>>,
        setExpandable: Binding<Bool>,
        setOnClick: @escaping (Set<String>) -> ()
    ) {
        self.getChipList = setChipList
        self._getSelectedChips = getSelectedChips
        self._getExpandable = setExpandable
        self.getOnClick = setOnClick
    }
    
    private let expandDuration = 0.25
    private let closeDuration = 0.1
    
    var body: some View {
        VStack {
            if getExpandable {
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 100))], // 칩 너비에 맞춰 자동 조정
                        spacing: 8
                    ) {
                        ForEach(getChipList, id: \.self) { chip in
                            ChipItem(
                                chipText: chip,
                                isSelected: getSelectedChips.contains(chip),
                                onTap: {
                                    toggleChipSelection(chip: chip)
                                    getOnClick(getSelectedChips)
                                }
                            )
                        }
                    }
                    .padding()
                    .transition(.move(edge: .top))  // 위쪽에서 아래로 펼쳐지는 애니메이션
                    .animation(.easeInOut(duration: getExpandable ? expandDuration : closeDuration), value: getExpandable)
                }
            }
        }
        .background(Color.red)
    }
    
    private func toggleChipSelection(chip: String) {
        if getSelectedChips.contains(chip) {
            getSelectedChips.remove(chip)
        } else {
            getSelectedChips.insert(chip)
        }
    }
}

