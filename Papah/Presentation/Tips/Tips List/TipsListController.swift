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
        let cell = tipsListTableView.dequeueReusableCell(withIdentifier: "tipsCell", for: indexPath) as! TipsListTableCell
//        cell.item = surah
        cell.setTips(with: item)
        print("CELL \(cell)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.viewModel = TipsListViewModel()

        tipsListTableView.delegate = self
        tipsListTableView.dataSource = self
        // Do any additional setup after loading the view.
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
