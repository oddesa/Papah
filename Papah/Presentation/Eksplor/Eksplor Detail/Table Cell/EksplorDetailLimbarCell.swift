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
        edtQuantity.becomeFirstResponder()
    }
    
    func updateViewData(data: WasteAccepted?, edtQuantity: Float) {
        self.lblLimbah.text = data?.wasteCategory?.title
        self.lblLimbahDesc.text = "Estimasi \(data?.price ?? 0) per-\(data?.wasteCategory?.unit ?? "")"
        self.edtQuantity.text = edtQuantity == 0 ? "" : String(edtQuantity)
        self.icLimbah.image = UIImage(data: data?.wasteCategory?.image ?? Data())
        
        changeBtnState()

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        edtQuantity.delegate = self
        edtQuantity.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }

    @IBAction func onBeginEditing(_ sender: Any) {
        let newPosition = edtQuantity.endOfDocument
        edtQuantity.selectedTextRange = edtQuantity.textRange(from: newPosition, to: newPosition)
        
    }
    
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    @objc func textFieldDidChange() {
        textChanged?(self.edtQuantity.text ?? "0")
        changeBtnState()
    }

    @IBAction func onEditingEnd(_ sender: UITextField) {
        changeBtnState()
    }
    
    func changeBtnState(){
        if(edtQuantity.text?.count ?? 0 > 0) {
            btnTambah.isHidden = true
            self.edtQuantity.isHidden = false
            self.edtQuantity.becomeFirstResponder()
        } else {
            btnTambah.isHidden = false
            self.edtQuantity.isHidden = true
            self.edtQuantity.resignFirstResponder()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
