//
//  EntryCell.swift
//  Journal
//
//  Created by Abdeen on 1/16/22.
//

import UIKit

class EntryCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelQuote: UILabel!
    
    @IBOutlet weak var imageViewStar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
