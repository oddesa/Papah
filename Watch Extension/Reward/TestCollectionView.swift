//
//  TestCollectionView.swift
//  Watch Extension
//
//  Created by Jehnsen Hirena Kane on 22/08/21.
//

import SwiftUI

struct TestCollectionView: View {
    var body: some View {
        
        let columns: [GridItem] =
            Array(repeating: .init(.flexible()), count: 3)
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0...100, id: \.self) { _ in
                    Image("33Watch").resizable().frame(width: 20, height: 20)
                }
            }
            
        }
    }
}

struct TestCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        TestCollectionView()
    }
}
