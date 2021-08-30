//
//  ContentView.swift
//  Watch Extension
//
//  Created by Dhiky Aldwiansyah on 20/08/21.
//

import SwiftUI

struct RewardView: View {
    
    
    var body: some View {
        
            ScrollView {
                Divider()
                    .padding(.bottom)
                TantanganBulanIniView()
                Divider()
                TantanganBulananView()
                    .padding(.vertical)
                Divider()
                RewardsLainnyaView()
                    .padding(.top)
            }.navigationTitle("Rewards")

        }
}

struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView()
    }
}
