//
//  ChatViewModel.swift
//  Flash Chat iOS13
//
//  Created by Bohirjon Akhmedov on 11/01/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

protocol ChatServiceDelegate {
    func messageUpdated(messages:[Message])
    func messageSent(message:Message)
}

class ChatViewModel {
    var messagingService: MessagingServiceProtocol
    var chatServiceDelegate: ChatServiceDelegate?
    
    init(messagingService: MessagingServiceProtocol) {
        self.messagingService = messagingService
        self.messagingService.messagingDelegate = self
    }
    
    func sendMessage(message: Message) {
        messagingService.sendMessage(message: message)
    }
}

extension ChatViewModel : MessagingDelegate {
    func messagesRecieved(messages: [Message]) {
        DispatchQueue.main.async {
            self.chatServiceDelegate?.messageUpdated(messages: messages)
        }
    }
    
    func messageSendingFailed(message: Message, errorMessage: String) {
        //TODO:
    }
    
    func messageSent(message: Message) {
        DispatchQueue.main.async {
            self.chatServiceDelegate?.messageSent(message: message)
        }
    }
}
