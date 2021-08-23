//
//  ContentView.swift
//  Watch Extension
//
//  Created by Dhiky Aldwiansyah on 20/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    var body: some View {
//        Button("Show Sheet") {
//                    showingSheet.toggle()
//                }
//                .sheet(isPresented: $showingSheet) {
//                    SheetView()
//                }
        
        Button(action: {
            print("button pressed")
            showingSheet.toggle()
        }) {
            Image("33Watch")
        }.sheet(isPresented: $showingSheet, content: {
            SheetView()
        })
        //RewardView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button("Press to dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
        .font(.title)
        .padding()
        .background(Color.black)
    }
}


