//
//  TantanganBulananView.swift
//  Watch Extension
//
//  Created by Jehnsen Hirena Kane on 22/08/21.
//

import SwiftUI

struct TantanganBulananView: View {
    @SwiftUI.Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    let columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 3)
    
    @State private var showingSheet = false
    @State private var monthlyChallenges = [BadgeProgress]()
    @State private var selectedBadge: Badge?
    
    var body: some View {
        VStack {
            HStack {
                Text("TANTANGAN BULANAN")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding([.leading, .bottom])
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 16, pinnedViews: [], content: {
                ForEach(self.monthlyChallenges, id:\.badge!.id) { mChall in
                    let monthBadge = mChall.badge
                    let stringGambar = monthBadge!.image! + "Watch"
                    let stringGambarAchieved = monthBadge!.image_achieved! + "Watch"
                    
                    (Button(action: {
                        self.showingSheet.toggle()
                        self.selectedBadge = mChall
                    }) {
                        Image(mChall.status ? stringGambarAchieved : stringGambar).resizable().frame(width: 40, height: 40, alignment: .center)
                    })
                    .id("\(mChall.badge!.id)TantanganBulanan")
                    .sheet(isPresented: self.$showingSheet) {
                        RewardDetailView(badge: self.$selectedBadge, showingSheet: self.$showingSheet)
                    }
                }.id("TantanganBulanan")
                
            })
            .buttonStyle(PlainButtonStyle())
        }.onAppear {
            if let data =  BadgeDataRepository.shared.getBadgeProgressByUserId(userId: 0) {
                for i in 0..<data.count {
                    if data[i].badge?.badge_category_id == 4 {
                        monthlyChallenges.append(data[i])
                    }
                }
            }
            print("ini bulanan ----------------------- \(monthlyChallenges.count)")
            for bajingan in monthlyChallenges {
                print(bajingan.badge!.id)
            }
        }
    }
}

struct TantanganBulananView_Previews: PreviewProvider {
    static var previews: some View {
        TantanganBulananView()
    }
}
