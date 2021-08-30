//
//  TantanganList.swift
//  Watch Extension
//
//  Created by Delvina Janice on 25/08/21.
//

import SwiftUI

struct TantanganList: View {
    var body: some View {
        HStack(spacing: 10.0) {
            Image("28Watch")
                .resizable()
                .frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text("Turis Sampah")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                Text("50000/50000")
                    .font(.footnote)
                    
                HStack {
                    Image("29Watch")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text("100%")
                        .font(.footnote)
                }
            }
        }
    }
}

struct TantanganList_Previews: PreviewProvider {
    static var previews: some View {
        TantanganList()
    }
}
