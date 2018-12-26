//
//  NessageCell.swift
//  Mitter Starter
//
//  Created by Vedavyas Bhat on 20/12/18.
//  Copyright © 2018 mitter.io. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet
    weak var container: UIView!
    
    @IBOutlet
    weak var senderName: UILabel!

    @IBOutlet
    weak var textPayload: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        contentView.clipsToBounds = true

        //contentView.layer.borderColor = UIColor.red.cgColor
        //contentView.layer.borderWidth = 1.0

        container.layer.borderColor = UIColor.yellow.cgColor
        container.layer.borderWidth = 1.0

        senderName.layer.borderColor = UIColor.blue.cgColor
        senderName.layer.borderWidth = 1.0

        textPayload.layer.borderColor = UIColor.green.cgColor
        textPayload.layer.borderWidth = 1.0
        textPayload.layer.cornerRadius = 5.0
        textPayload.layer.masksToBounds = false
        textPayload.lineBreakMode = .byWordWrapping
        textPayload.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
