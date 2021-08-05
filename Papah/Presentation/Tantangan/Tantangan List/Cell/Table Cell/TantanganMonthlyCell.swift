//
//  TantanganMonthlyCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/07/21.
//

import UIKit

class TantanganMonthlyCell: UITableViewCell {
    
    @IBOutlet weak var mcImage: UIImageView!
    @IBOutlet weak var mcTitle: UILabel!
    @IBOutlet weak var mcDesc: UILabel!
    @IBOutlet weak var mcProgressBar: UIProgressView!
    @IBOutlet weak var mcTextProgress: UILabel!
    @IBOutlet weak var mcClaimPointIcon: UIImageView!
    @IBOutlet weak var mcClaimPointDesc: UILabel!
    
    func updateDataView(mcData: MonthlyChallenge?, mcProgress: MonthlyChallengeProgress?) {
        if let mc = mcData {
            //mcImage.image = mc.image
            mcTitle.text = mc.title
            mcDesc.text = mc.desc
            if let mcp = mcProgress {
                let currentValue = String(format: "%.0f", mcp.current_value)
                let maxValue = String(format: "%.0f", mc.max_value)
                mcTextProgress.text = "\(currentValue) / \(maxValue)"
                if mcp.status == true {
                    mcClaimPointIcon.tintColor = .green
                } else {
                    mcClaimPointIcon.tintColor = .gray
                }
            }
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
