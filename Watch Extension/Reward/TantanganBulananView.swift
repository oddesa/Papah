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
    @State private var imageStr: String?
    
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
                    let img = mChall.status ? stringGambarAchieved : stringGambar
                    
                    (Button(action: {
                        self.showingSheet.toggle()
                        self.selectedBadge = monthBadge
                        self.imageStr = img
                    }) {
                        Image(img).resizable().frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                    .id("\(mChall.badge!.id)TantanganBulanan")
                    .sheet(isPresented: self.$showingSheet) {
                        RewardDetailView(image: self.$imageStr, badge: self.$selectedBadge, showingSheet: self.$showingSheet)
                    }
                }.id("TantanganBulanan")
                
            })
            .buttonStyle(PlainButtonStyle())
        }.onAppear {
            monthlyChallenges = []
            if let data =  BadgeDataRepository.shared.getBadgeProgressByUserId(userId: 0) {
                monthlyChallenges = data.filter {$0.badge?.badge_category_id == 4}
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
