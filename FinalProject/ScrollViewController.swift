//
//  ScrollViewController.swift
//  FinalProject
//
//  Created by User02 on 2018/12/26.
//  Copyright © 2018 User02. All rights reserved.
//

import UIKit


class ScrollViewController: UIViewController {
    
    var record:Record?
    var row:Int = 0
    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var dpicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let record = record {
            timeTextLabel.text = record.time
            eventTextField.text = record.event
        }
        
        dpicker.addTarget(self, action:#selector(self.show_pDate), for: UIControl.Event.valueChanged)
    
        // Do any additional setup after loading the view.
    }

    
    
    // MARK: - Navigation

    @IBAction func show_pDate(_ sender: UIButton) {
        let date = dpicker.date
        print(date)
        let dformattar = DateFormatter()
        dformattar.dateFormat = "yyyy-MM-dd HH:mm"
        let datestr = dformattar.string(from:date)
        timeTextLabel.text = datestr
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let tmp_event = eventTextField.text ?? ""
        let date = dpicker.date
        let dformattar = DateFormatter()
        dformattar.dateFormat = "yyyy-mm-dd HH:mm"
        let datestr = dformattar.string(from:date)
        record = Record(time:datestr , event: tmp_event)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var result = true
        if eventTextField.text?.isEmpty == true{
            result = false
            let alertController = UIAlertController(title: "", message: "請輸入事件名稱", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if timeTextLabel.text?.isEmpty == true{
            result = false
            let alertController = UIAlertController(title: "", message: "請輸入事件時間", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        return result
    }

}
