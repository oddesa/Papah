//
//  TantanganList.swift
//  Watch Extension
//
//  Created by Delvina Janice on 25/08/21.
//

import SwiftUI

struct TantanganList: View {
//    @Binding var image: String

    var image: String
    var monthChallProgress: MonthlyChallengeProgress
    
    var body: some View {
        
        let maxValueStr = String(format: "%.0f", monthChallProgress.monthlyChallenge!.max_value)
        let progressToGo = monthChallProgress.monthlyChallenge!.max_value - monthChallProgress.current_value
        let percent = monthChallProgress.current_value / monthChallProgress.monthlyChallenge!.max_value
        let progressToGoStr = String(format: "%.0f", progressToGo)
        let percentStr = String(format: "%.0f", percent)
        let maxValueCount = String(maxValueStr).count

        
        HStack(spacing: 10.0) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 29, height: 41)
            VStack(alignment: .leading) {
                Text(monthChallProgress.monthlyChallenge!.title!)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.accentColor)
                Text(maxValueCount == 1 ? "\(progressToGoStr) kali lagi!" : "Rp \(progressToGoStr) lagi!")
                    .font(.footnote)
                    
                HStack {
                    Image("40Watch")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                    Text("\(percentStr) %") //
                        .font(.footnote)
                }
            }
        }
        .padding()
    }
}
//
//struct TantanganList_Previews: PreviewProvider {
//    static var previews: some View {
//        TantanganList()
//    }
//}
