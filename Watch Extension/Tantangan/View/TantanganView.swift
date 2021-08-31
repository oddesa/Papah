//
//  ContentView.swift
//  Watch Extension
//
//  Created by Dhiky Aldwiansyah on 20/08/21.
//

import SwiftUI

struct TantanganView: View {
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    @State private var monthlyChallengeProgresses = [MonthlyChallengeProgress]()
    @State private var imageString = String()
    @State private var selectedMonthChall = MonthlyChallengeProgress()
    @State private var showingSheet = false
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 10, pinnedViews: [], content: {
                ForEach(self.monthlyChallengeProgresses) {mChall in
                    let gambarString = mChall.monthlyChallenge!.image! + "Watch"
                    (Button(action: {
                        self.showingSheet.toggle()
                        self.selectedMonthChall = mChall
                        self.imageString = gambarString
                    }) {
                        TantanganList(image: gambarString, monthChallProgress: mChall)
                    })
                    .sheet(isPresented: self.$showingSheet) {
                        TantanganDetailView(monthlyChallengeProgress: self.$selectedMonthChall, image: self.$imageString, showingSheet: self.$showingSheet)
                    }
                }
            })
        }
        .buttonStyle(PlainButtonStyle())
        .navigationTitle("Tantangan")
        .onAppear {
            monthlyChallengeProgresses = []
            if let data = MonthlyChallengeDataRepository.shared.getMCPByUserIdAndMonth(userId: 0, currentMonth: 8) {
                monthlyChallengeProgresses = data
                print("keload bangsat")
                
            }
        }
    }
}
//
//LazyVGrid(columns: columns, alignment: .center, spacing: 16, pinnedViews: [], content: {
//    ForEach(self.badgesProgresses, id: \.badge!.id) {badgeProgress in
//
//        let stringGambar = badgeProgress.badge!.image! + "Watch"
//        let stringGambarAchieved = badgeProgress.badge!.image_achieved! + "Watch"
//        let img = badgeProgress.status ? stringGambarAchieved : stringGambar
//
//        (Button(action: {
//            self.showingSheet.toggle()
//            self.selectedBadge = badgeProgress.badge
//            self.imageStr = img
//        }) {
//            Image(img).resizable().frame(width: 40, height: 40, alignment: .center)
//        })
//        .id("\(badgeProgress.badge!.id)RewardsLainnya")
//        .sheet(isPresented: self.$showingSheet) {
//            RewardDetailView(image: self.$imageStr, badge: self.$selectedBadge, showingSheet: self.$showingSheet)
//        }
//    }.id("RewardsLainnya")
//})
//.buttonStyle(PlainButtonStyle())


//struct TantanganView_Previews: PreviewProvider {
//    static var previews: some View {
//        TantanganView()
//    }
//}
