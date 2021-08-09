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
    
    func updateDataView(mcProgress: MonthlyChallengeProgress?) {
        if let mcp = mcProgress {
            let maxValueFloat = Float(mcp.monthlyChallenge?.max_value ?? 0)
            let currentValue = String(format: "%.0f", mcp.current_value)
            let maxValue = String(format: "%.0f", maxValueFloat)
           
            //mcImage.image = mc.image
            mcTitle.text = mcp.monthlyChallenge?.title
            mcDesc.text = mcp.monthlyChallenge?.desc
            mcImage.image = UIImage(data: mcp.monthlyChallenge?.image ?? Data())
            mcTextProgress.text = "\(currentValue) / \(maxValue)"
            mcProgressBar.progress = mcp.current_value / maxValueFloat

            if mcp.status == true {
                mcClaimPointDesc.text = "Kamu telah klaim 300 poin"
                mcClaimPointIcon.tintColor = .systemGreen
                mcClaimPointDesc.textColor = .systemGreen
            } else {
                mcClaimPointDesc.text = "Selesaikan misi untuk mendapatkan 300 poin"
                mcClaimPointDesc.textColor = .gray
                mcClaimPointIcon.tintColor = .gray
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
