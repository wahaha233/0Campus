//
//  CustomTableViewCell.swift
//  tableviewcontrol
//
//  Created by GeorgeMao on 2017/3/22.
//  Copyright © 2017年 GeorgeMao. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var provincelabel: UILabel!
    @IBOutlet weak var partlabel: UILabel!
    @IBOutlet weak var thumbimageview: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
