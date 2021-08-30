//
//  TantanganDetailView.swift
//  Watch Extension
//
//  Created by Delvina Janice on 26/08/21.
//

import SwiftUI

struct TantanganDetailView: View {
    @Binding var monthlyChallengeProgress: MonthlyChallengeProgress
    @Binding var image: String
    @Binding var showingSheet: Bool
    
    var body: some View {
        ScrollView{
            Image(image)
                .resizable()
                .frame(width: 110, height: 110)
            Text(monthlyChallengeProgress.monthlyChallenge!.title!)
                .bold()
                .font(.body)
            Text(monthlyChallengeProgress.monthlyChallenge!.desc!)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .frame(width: 175)
        }
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .cancellationAction) {
                Text("Closed").onTapGesture {
                    self.showingSheet.toggle()
                }.foregroundColor(.accentColor)
            }
        })
    }
}
//
//struct TantanganDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TantanganDetailView()
//    }
//}
