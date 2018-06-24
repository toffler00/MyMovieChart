//
//  MovieCell.swift
//  MyMovieChart
//
//  Created by ilhan won on 2018. 6. 15..
//  Copyright © 2018년 ilhan won. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var opendate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
