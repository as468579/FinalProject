//
//  RecordCell.swift
//  FinalProject
//
//  Created by User02 on 2018/12/26.
//  Copyright © 2018 User02. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {

    @IBOutlet weak var event: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var editor: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
