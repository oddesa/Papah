//
//  TantanganDetailView.swift
//  Watch Extension
//
//  Created by Delvina Janice on 26/08/21.
//

import SwiftUI

struct TantanganDetailView: View {
    var body: some View {
        ScrollView{
            Image("28Watch")
                .resizable()
                .frame(width: 110, height: 110)
            Text("Sultan Sampah")
                .bold()
                .font(.body)
            Text("Tabung Rp50.000 dari penjualan sampah")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .frame(width: 175)
        }
        .padding()
    }
}

struct TantanganDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TantanganDetailView()
    }
}
