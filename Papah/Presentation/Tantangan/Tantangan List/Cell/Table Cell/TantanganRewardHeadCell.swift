//
//  TantanganMonthlyHeadCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/07/21.
//

import UIKit

class TantanganRewardHeadCell: UITableViewHeaderFooterView {
    var onDidSelectItem: (() -> ())?
    
    @IBOutlet weak var tmpilkanOutlet: UIButton!
    @IBAction func tmpilkanBtn(_ sender: Any) {
        self.onDidSelectItem?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
