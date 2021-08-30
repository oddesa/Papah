//
//  RewardsLainnyaView.swift
//  Watch Extension
//
//  Created by Jehnsen Hirena Kane on 22/08/21.
//

import SwiftUI

struct RewardsLainnyaView: View {
    
    let gambars = ["28Watch","29Watch", "30Watch", "31Watch","32Watch", "33Watch"]
    let columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 3)
    @State private var showingSheet = false
    @State private var selectedBadgeProgress: BadgeProgress?
    @State var badgesProgresses = [BadgeProgress]()
    
    var body: some View {
        
        VStack {
            HStack {
                Text("TANTANGAN LAINNYA")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding([.leading, .bottom])
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 16, pinnedViews: [], content: {
                ForEach(self.badgesProgresses, id: \.badge!.id) {badgeProgress in
                    
                    let stringGambar = badgeProgress.badge!.image! + "Watch"
                    let stringGambarAchieved = badgeProgress.badge!.image_achieved! + "Watch"
                    
                    (Button(action: {
                        self.showingSheet.toggle()
                        self.selectedBadgeProgress = badgeProgress
                    }) {
                        Image(badgeProgress.status ? stringGambarAchieved : stringGambar).resizable().frame(width: 40, height: 40, alignment: .center)
                    })
                    .id("\(badgeProgress.badge!.id)RewardsLainnya")
                    .sheet(isPresented: self.$showingSheet) {
                        RewardDetailView(badgeProgress: self.$selectedBadgeProgress, showingSheet: self.$showingSheet)
                    }
                }.id("RewardsLainnya")
            })
            .buttonStyle(PlainButtonStyle())
            
        }.onAppear(perform: {
            if let data = BadgeDataRepository.shared.getBadgeProgressByUserId(userId: 0) {
                for i in 0..<data.count {
                    if data[i].badge!.badge_category_id != 4 {
                        badgesProgresses.append(data[i])
                    }
                }
            }
            print("ini rewardslainyaa ----------------------- \(badgesProgresses.count)")
            for bajingan in badgesProgresses {
                print(bajingan.id)
            }
        })
    }
}

struct RewardsLainnyaView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsLainnyaView()
    }
}


