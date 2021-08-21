//
//  TantanganListTableCell.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TantanganLevelTableCell: UITableViewCell {

    @IBOutlet weak var userLevel: UILabel!
    @IBOutlet weak var userPoin: UILabel!
    @IBOutlet weak var levelProgressBar: UIProgressView!
    @IBOutlet weak var levelValue: UILabel!
    @IBOutlet weak var pointLeftDesc: UILabel!
    
    var totalPoin = 500
    
    func updateDataView(userData: User?){
        if let user = userData {
            let userPoint = String(user.point)
            let pointLeft = totalPoin - Int(user.point)
            userLevel.text = "Level \(user.level): Murid Kurcaci"
            userPoin.text = userPoint
            levelValue.text = "\(totalPoin)"
            pointLeftDesc.text = "\(pointLeft) poin lagi untuk naik level"
            
            levelProgressBar.progress = Float(user.point)/500
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
