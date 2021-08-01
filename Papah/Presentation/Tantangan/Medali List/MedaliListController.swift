//
//  MedaliListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class MedaliListController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let subtitleText = ["Tantangan Bulanan", "Tantangan Lainnya"]
    
    var medaliBulanan = ["Tantangan Juni", "Tantangan Juli"]
    var medaliLainnya = ["Veteran", "Crazy Rich Kurcaci", "Professor Limbah", "Kurcaci Guru"]
    
    private var viewModel: MedaliListViewModel?
    
    init(viewModel: MedaliListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
        switch identifier {
        case MedaliListTableViewCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MedaliListTableViewCell else {
                return UITableViewCell()
            }
            
            cell.onDidSelectItem = {(indexPath) in
                let mdData = MedaliDetailData(image: UIImage.whatsAppImage20210719At085013, title: "akhirnya bisa yolo", desc: "kunci dari ngoding adalah tidur apabila pusyang berkepanjangan")
                let mdDatas = [mdData]
                self.navigationController?.pushViewController(MedaliDetailController.instantiateStoryboard(viewModel: MedaliDetailViewModel(datasVM: mdDatas)), animated: true)
            }
            
            return cell
        case SubtitleTableViewCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SubtitleTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
