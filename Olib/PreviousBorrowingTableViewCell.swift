//
//  PreviousBorrowingTableViewCell.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/15.
//

import UIKit

class PreviousBorrowingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var borrowDateLabel: UILabel!
    @IBOutlet weak var returnDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
