//
//  EksplorDetailLimbarCell.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 28/07/21.
//

import UIKit

class EksplorDetailLimbarCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var btnTambah: DesignableButton!
    @IBOutlet weak var edtQuantity: UITextField!
    @IBOutlet weak var icLimbah: UIImageView!
    @IBOutlet weak var viewIcLimbah: DesignableView!
    
    @IBOutlet weak var lblLimbah: UILabel!
    @IBOutlet weak var lblLimbahDesc: UILabel!
    
    var textChanged: ((String) -> Void)?

    @IBAction func onTapAdd(_ sender: Any) {
        btnTambah.isHidden = true
        edtQuantity.isHidden = false
    }
    
    func updateViewData(data: WasteAccepted?, edtQuantity: Float) {
        self.lblLimbah.text = data?.wasteCategory?.title
        self.lblLimbahDesc.text = "Estimasi \(data?.price ?? 0) per-\(data?.wasteCategory?.unit ?? "")"
        self.edtQuantity.text = edtQuantity == 0 ? "" : String(edtQuantity)
        
        if(edtQuantity > 0) {
            btnTambah.isHidden = true
            self.edtQuantity.isHidden = false
        } else {
            btnTambah.isHidden = false
            self.edtQuantity.isHidden = true
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        edtQuantity.delegate = self
        edtQuantity.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }

    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    @objc func textFieldDidChange() {
        textChanged?(self.edtQuantity.text ?? "0")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
