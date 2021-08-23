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
            
            LazyVGrid(columns: columns, alignment: .center, spacing: nil, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                ForEach(gambars, id: \.self) {gambar in
                    Button(action: {
                        showingSheet.toggle()
                    }) {
                        Image(gambar).resizable().frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.sheet(isPresented: $showingSheet) {
                        RewardDetailView()
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
            
        }
        
        
    }
}

struct RewardsLainnyaView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsLainnyaView()
    }
}


