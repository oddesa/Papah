//
//  TipsListController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TipsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tipsList[indexPath.row]
        let cell = tipsListTableView.dequeueReusableCell(withIdentifier: "tipsCell", for: indexPath) as! TipsListTableCell
//        cell.item = surah
        cell.setTips(with: item)
        print("CELL \(cell)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    private let viewModel = TipsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tipsListTableView.delegate = self
        tipsListTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tipsListTableView: UITableView!
    @IBOutlet weak var tipsSearchBar: UISearchBar!

    private let tipsList = [ Waste(image: "yes", category: "plastik", desc: "plastik lama terurai"), Waste(image: "yes", category: "kaleng", desc: "kaleng sangat lama terurai"), Waste(image: "yes", category: "kaleng-kaleng", desc: "juga lama terurai")]
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

struct Waste{
    let image: String
    let category : String
    let desc : String
}
