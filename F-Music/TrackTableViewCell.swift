//
//  TrackTableViewCell.swift
//  F-Music
//
//  Created by Alex on 06/07/16.
//  Copyright © 2016 Alexander Roschin. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    // MARK: Properties
    ///Connecting track name label to TrackTableViewCell.swift
    @IBOutlet weak var nameLabel: UILabel!
    ///Connecting artist name label to TrackTableViewCell.swift
    @IBOutlet weak var artistLabel: UILabel!
    ///Connecting album cover image to TrackTableViewCell.swift
    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
