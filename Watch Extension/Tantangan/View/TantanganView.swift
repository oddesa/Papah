//
//  ContentView.swift
//  Watch Extension
//
//  Created by Dhiky Aldwiansyah on 20/08/21.
//

import SwiftUI

struct TantanganView: View {
    var body: some View {
        NavigationView {
            List(0 ..< 2) { item in
                NavigationLink(destination: TantanganDetailView()) {
                    TantanganList()
                }
            }
        }
        .navigationTitle("Tantangan")
    }
}

struct TantanganView_Previews: PreviewProvider {
    static var previews: some View {
        TantanganView()
    }
}
