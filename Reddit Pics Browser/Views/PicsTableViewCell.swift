//
//  PicsTableViewCell.swift
//  Reddit Pics Browser
//
//  Created by AMAN JAIN on 26/06/22.
//

import UIKit

class PicsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var picImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for pic: ChildData?) {
        titleLabel.text = pic?.title
        dateLabel.text = pic?.created.getDate()
        if let imageUrl = pic?.url {
            picImageView.loadImage(withUrl: imageUrl)
        } else {
            picImageView.image = nil
        }
    }
    
    func configure(for pic: FavoritePics?) {
        titleLabel.text = pic?.title
        dateLabel.text = pic?.created.getDate()
        if let imageUrl = pic?.url {
            picImageView.loadImage(withUrl: imageUrl)
        } else {
            picImageView.image = nil
        }
    }

}
