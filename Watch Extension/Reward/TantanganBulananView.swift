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
           
            LazyVGrid(columns: columns, alignment: .center, spacing: nil, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                ForEach(gambars, id: \.self) {gambar in
                    NavigationLink(destination: RewardDetailView() ) {
                        Image(gambar).resizable().frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
            })
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct TantanganBulananView_Previews: PreviewProvider {
    static var previews: some View {
        TantanganBulananView()
    }
}
