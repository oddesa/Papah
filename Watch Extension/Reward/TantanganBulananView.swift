//
//  TantanganBulananView.swift
//  Watch Extension
//
//  Created by Jehnsen Hirena Kane on 22/08/21.
//

import SwiftUI

struct TantanganBulananView: View {
    let gambars = ["28Watch","29Watch", "30Watch", "31Watch","32Watch", "33Watch"]
    let columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 3)
    @State private var showingSheet = false
    @State var monthlyChallenges = [BadgeProgress]()
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
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 16, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                ForEach(self.monthlyChallenges) { mChall in
                    let monthBadge = mChall.badge
                    let imageString = monthBadge?.image ?? "33" + "Watch"
                    Button(action: {
                        showingSheet.toggle()
                    }) {
                        Image(imageString).resizable().frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.sheet(isPresented: $showingSheet) {
                        RewardDetailView(badge: monthBadge!)
                            .toolbar(content: {
                                ToolbarItem(placement: .cancellationAction) {
                                    Text("Closed").onTapGesture {
                                        self.showingSheet = false
                                    }.foregroundColor(.accentColor)
                                }
                            })
                        
                    }
                }
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
        }
    }
}

struct TantanganBulananView_Previews: PreviewProvider {
    static var previews: some View {
        TantanganBulananView()
    }
}
