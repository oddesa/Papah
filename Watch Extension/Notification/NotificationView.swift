//
//  NotificationView.swift
//  Watch Extension
//
//  Created by Dhiky Aldwiansyah on 20/08/21.
//

import SwiftUI

struct NotificationView: View {
    var title: String?
    var message: String?
    
    var body: some View {
        ScrollView {
                VStack {
            //            Image(systemName: "photo")
            //            Text("Dapat Rewards")
                    Image("33Watch").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(title ?? "Dapat Rewards")
                        .font(.headline)
                    Divider()
                    Text(message ?? "Berhasil Meraih \"Kurcaci Penyalur\" ")
                        .font(.caption)
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Lihat Rewards")
                    }
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Tutup")
                    }
                }
//                .lineLimit(0)
                
            }
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NotificationView()
            NotificationView(title: "Dapat Rewards",
                                         message: "Berhasil Meraih \"Kurcaci Penyalur\" "
                            )

        }
        
        
    }
}
