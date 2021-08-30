//
//  TantanganDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TantanganDetailController: MVVMViewController<TantanganDetailViewModel> {
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsIcon: UIImageView!
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsTable: UITableView!
    
    @IBAction func donePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle(selected: viewModel?.selectedRow ?? 0)
        nibSetup()
        tableViewSetup()
        navigationController?.navigationBar.tintColor = .link
        navBar.tintColor = .link
    }
}

//MARK: TableView
extension TantanganDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.challengeDetailData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tantanganDetail") as? TantanganDetailTableCell else {return UITableViewCell()}
        
        let cdData = viewModel?.challengeDetailData[indexPath.row]
        let selectedRow = viewModel?.selectedRow
        
        if selectedRow == cdData?.id{
            cell.guideImage.image = cdData?.img
            cell.guideTitle.text = cdData?.title
            cell.guideDesc.text = cdData?.desc
            
            cell.guideImage.tintColor = .link
        }
        
        return cell
    }
    
}

//MARK: Function
extension TantanganDetailController {
    
    func nibSetup() {
        let nib = UINib(nibName: "\(TantanganDetailTableCell.self)", bundle: nil)
        detailsTable.register(nib, forCellReuseIdentifier: "tantanganDetail")
    }
    
    func tableViewSetup() {
        detailsTable.dataSource = self
        detailsTable.tableFooterView = UIView()
        detailsTable.separatorColor = .clear
    }
    
    func setupTitle(selected: Int) {
        if selected == 0 {
            titleImg.image = UIImage._22_img
            titleLabel.text = "Cara klaim poin penjualan sampah "
        } else {
            titleImg.image = UIImage._23_img
            titleLabel.text = "Cara tabung uang penjualan sampah"
        }
    }
    
    func navBarSetup() {}
}
