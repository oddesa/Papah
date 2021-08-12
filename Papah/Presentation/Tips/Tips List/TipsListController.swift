//
//  TipsListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TipsListController: MVVMViewController<TipsListViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tipsListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = TipsListViewModel()
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        setupXib()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

// MARK: - TableView Delegate & Data Source
    func setupXib() {
        self.tipsListTableView.register(TipsListTableCell.nib, forCellReuseIdentifier: TipsListTableCell.cellIdentifier())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getTipsData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.viewModel?.getTipsData()?[indexPath.row]
        guard let cell = tipsListTableView.dequeueReusableCell(withIdentifier: TipsListTableCell.cellIdentifier(), for: indexPath) as? TipsListTableCell else {return UITableViewCell()}
        
        cell.setTips(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //-Rizqi's addition-----------------------------------------------------------
        
        if indexPath.row == 0 {
            if let viewModel = viewModel, let tipsData = viewModel.getTipsData()?[indexPath.row] {
                let controller = TipsDetailController.instantiateStoryboard(
                    viewModel: TipsDetailViewModel(tips: tipsData)
                )
                self.navigationController?.pushViewController(controller, animated: true)
            }
        } else {
            self.showAlert(title: "Akan hadir!", msg: "Masih dalam pengerjaan.")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerFrame = tableView.frame
//
//        let title = UILabel()
//        title.frame =  CGRect(x: 16, y: 0, width: headerFrame.size.width-20, height: 20) //width equals to parent view with 10 left and right margin
//        title.font = title.font.withSize(14)
//        title.text = "MENYALURKAN LIMBAH"
//        //        title.text = self.tableView(tableView, titleForHeaderInSection: section) //This will take title of section from 'titleForHeaderInSection' method or you can write directly
//        title.textColor = .gray
//
//        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
//        headerView.addSubview(title)
//        return headerView
//    }

    
    
}
