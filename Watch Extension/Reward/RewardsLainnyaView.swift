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
    @State private var selectedBadge: Badge?
    @State var badgesProgresses = [BadgeProgress]()
    @State var imageStr: String?
    
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
                    let img = badgeProgress.status ? stringGambarAchieved : stringGambar
                    
                    (Button(action: {
                        self.showingSheet.toggle()
                        self.selectedBadge = badgeProgress.badge
                        self.imageStr = img
                    }) {
                        Image(img).resizable().frame(width: 40, height: 40, alignment: .center)
                    })
                    .id("\(badgeProgress.badge!.id)RewardsLainnya")
                    .sheet(isPresented: self.$showingSheet) {
                        RewardDetailView(image: self.$imageStr, badge: self.$selectedBadge, showingSheet: self.$showingSheet)
                    }
                }.id("RewardsLainnya")
            })
            .buttonStyle(PlainButtonStyle())
            
        }.onAppear(perform: {
            badgesProgresses = []
            if let data = BadgeDataRepository.shared.getBadgeProgressByUserId(userId: 0) {
                badgesProgresses = data.filter {$0.badge?.badge_category_id != 4}
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


