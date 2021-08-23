//
//  TantanganBulanIniView.swift
//  Watch Extension
//
//  Created by Jehnsen Hirena Kane on 22/08/21.
//

import SwiftUI

struct TantanganBulanIniView: View {
    
    
    var body: some View {
    
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("TANTANGAN AGUSTUS")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                    Spacer()
                }
               
                Text("1 DARI 2 SELESAI")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    
            }
            .padding(.leading).padding(.bottom)
            
            Image("33Watch").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .padding(.bottom)
                
    }
}

struct TantanganBulanIniView_Previews: PreviewProvider {
    static var previews: some View {
        TantanganBulanIniView()
    }
}
