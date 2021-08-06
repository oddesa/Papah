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
    
    func updateDataView(userData: User?){
        if let user = userData {
            let userPoint = String(user.point)
            userLevel.text = "Level \(user.level): Murid Kurcaci"
            userPoin.text = userPoint
            levelValue.text = "\(userPoint) / 500"
            pointLeftDesc.text = "Kumpulkan 500 poin lagi untuk naik level"
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
