//
//  MedaliListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class MedaliListController: MVVMViewController<MedaliListViewModel>   {
    
    @IBOutlet var tableView: UITableView!
    
    let subtitleText = ["Tantangan Bulanan", "Tantangan Lainnya"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
}

extension MedaliListController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: MedaliListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MedaliListTableViewCell.identifier)
        tableView.register(UINib(nibName: SubtitleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SubtitleTableViewCell.identifier)
    }
    func tableViewIdentifier() -> [String] {
        var identifier = [String]()
        
        identifier.append(SubtitleTableViewCell.identifier)
        identifier.append(MedaliListTableViewCell.identifier)
        identifier.append(SubtitleTableViewCell.identifier)
        identifier.append(MedaliListTableViewCell.identifier)
        
        return identifier
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewIdentifier().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = self.tableViewIdentifier()[indexPath.row]
        let badgeProgress = self.viewModel?.badgeProgress
        
        switch identifier {
        case MedaliListTableViewCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MedaliListTableViewCell else {
                return UITableViewCell()
            }
            let temp = badgeProgress ?? []
            var mbData = [BadgeProgress]()
            var medalData = [BadgeProgress]()
            
            for i in 0..<temp.count {
                if temp[i].badge?.badge_category_id == 4 {
                    mbData.append(temp[i])
                }
                if temp[i].badge?.badge_category_id != 4 {
                    medalData.append(temp[i])
                }
            }
            
            if indexPath.row == 1 {
                cell.setData(bpData: mbData, tableIndex: indexPath.row)
                cell.onDidSelectItem = {(i) in
                    let badge = mbData[i.row].badge
                    let imgAchieved = badge?.image_achieved ?? Data()
                    let imgNotAchieved = badge?.image ?? Data()
                    let img = mbData[i.row].status ?  imgAchieved : imgNotAchieved
                    
                    let title =   badge?.title ?? ""
                    let desc =  badge?.desc ?? ""
                    let mdData = MedaliDetailData(image: UIImage(data: img) ?? UIImage(), title: title , desc:desc)
                    
                    let mdDatas = [mdData]
                    self.navigationController?.pushViewController(MedaliDetailController.instantiateStoryboard(viewModel: MedaliDetailViewModel(datasVM: mdDatas)), animated: true)
                }
            } else if indexPath.row == 3 {
                cell.setData(bpData: medalData, tableIndex: indexPath.row)
                cell.onDidSelectItem = {(i) in
                    let badge = medalData[i.row].badge
                    let imgAchieved = badge?.image_achieved ?? Data()
                    let imgNotAchieved = badge?.image ?? Data()
                    let img = medalData[i.row].status ?  imgAchieved : imgNotAchieved
      
                    let title =   badge?.title ?? ""
                    let desc =  badge?.desc ?? ""
                    let mdData = MedaliDetailData(image: UIImage(data: img) ?? UIImage(), title: title , desc:desc)
                    
                    let mdDatas = [mdData]
                    self.navigationController?.pushViewController(MedaliDetailController.instantiateStoryboard(viewModel: MedaliDetailViewModel(datasVM: mdDatas)), animated: true)
                }
            }
            
            return cell
        case SubtitleTableViewCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SubtitleTableViewCell else {
                return UITableViewCell()
            }
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0);
            if indexPath.row == 0 {
                cell.updateTitleLabel(title: subtitleText[0])
            } else if indexPath.row == 2 {
                cell.updateTitleLabel(title: subtitleText[1])
            }
            
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return tableView.bounds.height
        } else {
            return UITableView.automaticDimension
        }
    }
}
