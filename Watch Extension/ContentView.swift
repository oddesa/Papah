//
//  ContentView.swift
//  Watch Extension
//
//  Created by Dhiky Aldwiansyah on 20/08/21.
//

import SwiftUI

struct ContentView: View {
    @SwiftUI.Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        TantanganView()
        RewardView()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
