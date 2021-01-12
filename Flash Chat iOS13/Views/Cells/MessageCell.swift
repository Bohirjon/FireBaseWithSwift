//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Bohirjon Akhmedov on 11/01/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var youAvatarImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var meAvatarImage: UIImageView!
    
    var message: Message?
    var isSentMessage:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let safeMessage = message {
            if isSentMessage {
                youAvatarImage.isHidden = true
            } else {
                meAvatarImage.isHidden = true
            }
            messageLabel.text = safeMessage.message
        }
    }
    
}
