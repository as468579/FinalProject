//
//  RecordViewController.swift
//  FinalProject
//
//  Created by User02 on 2018/12/26.
//  Copyright © 2018 User02. All rights reserved.
//

import UIKit


class RecordViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    var items = [Record]()
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var JPRateTextField: UILabel!
    @IBOutlet weak var USRateTextField: UILabel!
    var Exrate : tradeInfo?
    @IBAction func unwindToRecordView(seque : UIStoryboardSegue){
        if let source = seque.source as? ScrollViewController,
            let record = source.record{
                let row = source.row
                if row != 0 {
                    items.remove(at: row)
                }
                items.insert(record,at: row)
                Record.save(records:items)
                tableView.reloadData()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let records = Record.read() {
            self.items = records
        }
        if let urlStr = "https://api.myjson.com/bins/e5exg".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                if let data = data, let Exrate = try? decoder.decode(tradeInfo.self, from: data) {
                    self.Exrate = tradeInfo(USDTWD: Exrate.USDTWD, USDJPY: Exrate.USDJPY, USDCNY: Exrate.USDCNY)
                    
                    DispatchQueue.main.async {
                        self.USRateTextField.text = String(format: "%.2f",Exrate.USDTWD.Exrate)
                        self.JPRateTextField.text = String(format: "%.2f",Exrate.USDJPY.Exrate/Exrate.USDTWD.Exrate)
                    }
                    
                }
            }
            task.resume()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? ScrollViewController, let row = tableView.indexPathForSelectedRow?.row {
            controller.record = items[row]
            controller.row = row
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        let item = items[indexPath.row]
        cell.time?.text = item.time
        cell.event?.text = item.event
        return cell
    }

}
