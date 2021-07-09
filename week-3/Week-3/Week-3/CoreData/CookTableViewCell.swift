//
//  CookTableViewCell.swift
//  Week-3
//
//  Created by Samed Biçer on 10.07.2021.
//

import UIKit

class CookTableViewCell: UITableViewCell {
    @IBOutlet weak var cookImageView: UIImageView!
    @IBOutlet weak var cookLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
