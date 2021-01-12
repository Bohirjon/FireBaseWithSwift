//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.


import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let viewModel: ChatViewModel = ChatViewModel(messagingService: MessagingService())
    
    var messages = [Message]()
    let currentUserEmail = Auth.auth().currentUser?.email
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.chatServiceDelegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.MessageCellNib, bundle: nil), forCellReuseIdentifier: Constants.MessageCellIdentity)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let from = Auth.auth().currentUser?.email, let message =  messageTextfield.text {
            let secondsSince1970 = NSDate().timeIntervalSince1970
            let message = Message(from: from, message: message, sentDate: secondsSince1970)
            viewModel.sendMessage(message: message )
        }
        messageTextfield.text = ""
    }
}

extension ChatViewController : ChatServiceDelegate {
    func messageUpdated(messages: [Message]) {
        self.messages = messages
        tableView.reloadData()
    }
    
    func messageSent(message: Message) {
        //TODO:
    }
}

extension ChatViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let messageCell = tableView.dequeueReusableCell(withIdentifier: Constants.MessageCellIdentity) as! MessageCell
        messageCell.message = message
        messageCell.isSentMessage = currentUserEmail == message.from
        return messageCell
    }
}
