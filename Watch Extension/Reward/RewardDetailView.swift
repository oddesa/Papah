//
//  RewardDetailView.swift
//  Watch Extension
//
//  Created by Jehnsen Hirena Kane on 22/08/21.
//

import SwiftUI

struct RewardDetailView: View {
    
    @Binding var badge: Badge?
    @Binding var showingSheet: Bool
    @Environment(\.presentationMode)
    var presentationMode

    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                let gambarString = badge!.image! + "Watch"
                Image(gambarString).resizable().padding().frame(width: 138, height: 138, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text(badge!.title ?? "HAAAH TIDAK ADA")
                    .fontWeight(.semibold).font(.system(size: 17))
                
                Text(badge!.desc ?? "aaaaaaa anjeng ilaang")
                    .fontWeight(.regular)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .cancellationAction) {
                Text("Closed").onTapGesture {
                    self.showingSheet.toggle()
                }.foregroundColor(.accentColor)
            }
        })
        
    }
}
//
//struct RewardDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RewardDetailView(badge: <#Badge#>)
//    }
//}
