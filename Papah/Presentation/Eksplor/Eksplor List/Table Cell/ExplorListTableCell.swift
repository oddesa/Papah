//
//  ExplorListTableCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 25/07/21.
//

import UIKit

class ExplorListTableCell: UITableViewCell {

    @IBOutlet weak var wbklNameLabel: PaddingLabel!
    @IBOutlet weak var wbklCategoryLabel: PaddingLabel!
    @IBOutlet weak var wbklOperationalLabel: PaddingLabel!
    @IBOutlet weak var wbklPhoto: UIImageView!
    
    @IBOutlet weak var wbklSampahKategori1: DesignableView!
    
    @IBOutlet weak var wbklSampahKateogri1Label: UILabel!
    
    @IBOutlet weak var wbklSampahKategori2: DesignableView!
    
    @IBOutlet weak var wbklSampahKategori2Label: UILabel!
    
    @IBOutlet weak var wbklSampahKategori3: DesignableView!
    
    @IBOutlet weak var wbklSampahKategori3Label: UILabel!
    
    @IBOutlet weak var wbklSampahKategori4: DesignableView!
    
    @IBOutlet weak var wbklSampahKategori4Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
