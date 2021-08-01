//
//  TantanganDetailController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TantanganDetailController: UIViewController {
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var detailsIcon: UIImageView!
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsTable: UITableView!
    
    @IBAction func donePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
    
   var viewModel: TantanganDetailViewModel?
    
    init(viewModel: TantanganDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nibSetup()
        tableViewSetup()
    }
}

//MARK: TableView
extension TantanganDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.challengeDetailData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tantanganDetail") as! TantanganDetailTableCell
        
        let cdData = viewModel?.challengeDetailData[indexPath.row]
        cell.guideImage.image = cdData?.img
        cell.guideTitle.text = cdData?.title
        cell.guideDesc.text = cdData?.desc
        
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
    
    func navBarSetup() {
       /* let navigationBarAppearence = UINavigationBarAppearance()
        navigationBarAppearence.shadowColor = .white
        navigationBarAppearence.shadowImage = UIImage()
        navBar.scrollEdgeAppearance = navigationBarAppearence*/
    }
}
