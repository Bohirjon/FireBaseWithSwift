//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Bohirjon Akhmedov on 11/01/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
struct Constants {
    
    static let MessageCellIdentity = "MessageCellIdentity"
    static let MessageCellNib = "MessageCell"
    struct DataBase {
        static let MessagesCollection = "messages"
        static let SenderField = "sender"
        static let MessageField = "message"
        static let MessageSentDateField = "sentDate"
    }
    struct Cells {
        static let SentMessageCell = "fromMessageCell"
        static let RecievedMessageCell = "recievedMessageCell"
    }
}
