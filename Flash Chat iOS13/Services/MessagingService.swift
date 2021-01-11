//
//  MessagingService.swift
//  Flash Chat iOS13
//
//  Created by Bohirjon Akhmedov on 11/01/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//


import FirebaseFirestore
import Firebase

//Mark: - MessagingDelegate
protocol MessagingDelegate {
    func messageRecieved(message:Message)
    func messageSendingFailed(message:Message, errorMessage:String)
    func messageSent(message:Message)
}

//Mark: - MessagingServiceProtocol
protocol MessagingServiceProtocol {
    var messagingDelegate: MessagingDelegate? {get set}
    func sendMessage(message:Message)
}

//Mark : - MessagingService
class MessagingService: MessagingServiceProtocol {
    var messagingDelegate: MessagingDelegate?
    var firestore: Firestore?
    
    init(messagingDelegate: MessagingDelegate) {
        self.messagingDelegate = messagingDelegate
        firestore = Firestore.firestore()
    }
    
    func sendMessage(message: Message) {
        firestore?.collection(Constants.DataBase.MessagesCollection)
            .addDocument(data: [
                            Constants.DataBase.SenderField : message.from
                            ,Constants.DataBase.MessageField: message.message
                            ,Constants.DataBase.MessageSentDateField: message.sentDate],
                         completion: { (error) in
                            if let safeError = error {
                                self.messagingDelegate?.messageSendingFailed(message: message, errorMessage: safeError.localizedDescription)
                            }else {
                                self.messagingDelegate?.messageSent(message: message)
                            }
                         })
    }
}
