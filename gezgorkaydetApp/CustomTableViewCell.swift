//
//  CustomTableViewCell.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/26/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var yerleskeResmi: UIImageView!
    @IBOutlet weak var yerleskeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
