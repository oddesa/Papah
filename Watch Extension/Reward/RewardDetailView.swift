//
//  RewardDetailView.swift
//  Watch Extension
//
//  Created by Jehnsen Hirena Kane on 22/08/21.
//

import SwiftUI

struct RewardDetailView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    
                    Image("33Watch").resizable().padding().frame(width: 138, height: 138, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Text("Kurcaci Penyalur")
                        .fontWeight(.semibold).font(.system(size: 17))
                    
                    Text("Kamu memeroleh medali ini saat kamu berhasil mengumpulkan 15kg sampah inorganik. ")
                        .fontWeight(.regular)
                        .font(.system(size: 17))
                        .multilineTextAlignment(.center)
                        
                }
            }
        }
            
    }
}

struct RewardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RewardDetailView()
    }
}
