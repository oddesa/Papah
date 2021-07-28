//
//  EksplorListFilterViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

struct FilterWaste {
    let id: String = UUID().uuidString
    let img: UIImage?
    let title: String?
    var isSelected: Bool?
    
    static func getFilterWasteData() -> [FilterWaste]{
        var fwData = [FilterWaste]()
        //let obImage = BagelsOnboardingImage()
        
        let fwData1 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Elektronik", isSelected: false)
        let fwData2 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Kardus", isSelected: false)
        let fwData3 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Kertas", isSelected: false)
        let fwData4 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Perabot", isSelected: false)
        let fwData5 = FilterWaste(img: #imageLiteral(resourceName: "WhatsApp Image 2021-07-19 at 08.50.13"), title: "Plastik", isSelected: false)
        
        fwData.append(fwData1)
        fwData.append(fwData2)
        fwData.append(fwData3)
        fwData.append(fwData4)
        fwData.append(fwData5)

        return fwData
    }
}

class EksplorListFilterViewModel: NSObject {

}
