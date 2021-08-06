//
//  SubtitleViewCell.swift
//  Papah
//
//  Created by Rizqi Ahmad Kurniawan on 28/07/21.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {

    static let identifier = "SubtitleTableViewCell"

    @IBOutlet weak var subtitleLabel: UILabel!
    
    func updateTitleLabel(title: String){
        subtitleLabel.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
