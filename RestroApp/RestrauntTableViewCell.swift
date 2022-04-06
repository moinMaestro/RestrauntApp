//
//  RestrauntTableViewCell.swift
//  RestroApp
//
//  Created by khalid moin on 08/03/22.
//

import UIKit

class RestrauntTableViewCell: UITableViewCell {

    @IBOutlet var imageRestraunt: UIImageView!
    @IBOutlet var lblRestrauntName: UILabel!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var lblAddres: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func designCell(data: RestrauntModal){
        self.lblRestrauntName.text = String.getString(data.name)
        
        self.lblRating.text = "Total Number of Ratings: \(String.getString(data.user_ratings_total))"
        
        self.lblAddres.text = String.getString(data.vicinity)
    }

}
