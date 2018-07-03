//
//  TheaterCell.swift
//  MyMovieChart
//
//  Created by ilhan won on 2018. 7. 2..
//  Copyright © 2018년 ilhan won. All rights reserved.
//

import UIKit

class TheaterCell: UITableViewCell {
    // 상영관명
    @IBOutlet weak var name: UILabel!
    // 연락처
    @IBOutlet weak var tell: UILabel!
    // 주소
    @IBOutlet weak var addr: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
