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
    func messagesRecieved(messages:[Message])
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
    
    init() {
        firestore = Firestore.firestore()
        firestore?.collection(Constants.DataBase.MessagesCollection)
            .order(by: Constants.DataBase.MessageSentDateField)
            .addSnapshotListener { (snapshot, error) in
                if let safeError = error {
                    print(safeError)
                } else {
                    if  let documents = snapshot?.documents {
                        var messages = [Message]()
                        
                        for document in documents {
                            let data = document.data()
                            let sender = data[Constants.DataBase.SenderField] as! String
                            let messageContent = data[Constants.DataBase.MessageField] as! String
                            let dateSeconds = data[Constants.DataBase.MessageSentDateField] as! Double
                            
                            let message = Message(from: sender, message: messageContent, sentDate: dateSeconds)
                            messages.append(message)
                        }
                        self.messagingDelegate?.messagesRecieved(messages: messages)
                    }
                }
            }
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
                            } else {
                                self.messagingDelegate?.messageSent(message: message)
                            }
                         })
    }
}
