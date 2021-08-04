//
//  TipsListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TipsListController: MVVMViewController<TipsListViewModel>, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getTipsData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.viewModel?.getTipsData()?[indexPath.row]
        let cell = tipsListTableView.dequeueReusableCell(withIdentifier: TipsListTableCell.cellIdentifier(), for: indexPath) as! TipsListTableCell
//        cell.item = surah
        cell.setTips(with: item)
        print("CELL \(cell)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DID SELECT")
        
        //-Rizqi's addition-----------------------------------------------------------
        if let viewModel = viewModel, let tipsData = viewModel.getTipsData()?[indexPath.row] {
            let controller = TipsDetailController.instantiateStoryboard(
                viewModel: TipsDetailViewModel(tips: tipsData)
            )
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerFrame = tableView.frame
        
        let title = UILabel()
        title.frame =  CGRect(x: 16, y: 0, width: headerFrame.size.width-20, height: 20) //width equals to parent view with 10 left and right margin
        title.font = title.font.withSize(14)
        title.text = "MENYALURKAN LIMBAH"
        //        title.text = self.tableView(tableView, titleForHeaderInSection: section) //This will take title of section from 'titleForHeaderInSection' method or you can write directly
        title.textColor = .gray
        
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        headerView.addSubview(title)
        return headerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = TipsListViewModel()

        setupXib()
        
    }
    
    func setupXib(){
        self.tipsListTableView.register(TipsListTableCell.nib, forCellReuseIdentifier: TipsListTableCell.cellIdentifier())
    }
    
    @IBOutlet weak var tipsListTableView: UITableView!
    @IBOutlet weak var tipsSearchBar: UISearchBar!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
