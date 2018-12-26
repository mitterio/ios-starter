//
//  ChannelWindowViewController.swift
//  Mitter Starter
//
//  Created by Vedavyas Bhat on 15/12/18.
//  Copyright © 2018 mitter.io. All rights reserved.
//

import UIKit
import Mitter
import SnapKit
import IQKeyboardManagerSwift

class ChannelWindowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var channelId = String()
    var messages = [Message]()

    let cellReuseIdentifier = "messageCell"

    @IBOutlet
    var tableView: UITableView!

    @IBOutlet
    var inputText: UITextField!

    @IBOutlet
    var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.tableView.register(UINib(nibName: "NessageCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none

        //Set 0 height footer to hide empty rows
        tableView.tableFooterView = UIView(frame: .zero)

        //sendButton.setImage(UIImage(named: "send.png"), for: .normal)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

        // Fetch all Messages in Channel
        appDelegate.mitter.messaging.getMessagesInChannel(channelId) {
            result in
            switch result {
            case .success(let fetchedMessages):
                print("Fetched \(fetchedMessages.count) messages")
                self.messages = fetchedMessages.reversed()
                self.tableView.reloadData()
            case .error:
                print("Couldn't fetch messages")
            }
        }
    }

    @objc func buttonClicked() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.mitter.messaging.sendTextMessage(forChannel: channelId, inputText.text!) { result in
            switch result {
            case .success:
                print("Message sent!")
            case .error:
                print("Couldn't send message")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell: MessageCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MessageCell!

        // set the message text and sender name
        let mitter = (UIApplication.shared.delegate as! AppDelegate).mitter

        let message = self.messages[indexPath.row]

        cell.textPayload.text = message.textPayload
        cell.senderName.text = message.senderId.domainId

        cell.container.sizeToFit()

        if mitter.getUserId() == message.senderId.domainId {
            //If message is by current user, align to right
            cell.container.snp.makeConstraints { (make) -> Void in
                make.right.equalTo(cell.contentView.snp.right).offset(10)
            }
            //Change color to ligh purple
            cell.textPayload.backgroundColor = UIColor(rgb: 0xe284ff)
        } else {
            //else align to left
            cell.container.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(cell.contentView.snp.left).offset(10)
            }

            //Change color to dark purple
            cell.textPayload.backgroundColor = UIColor(rgb: 0xac60c4)
        }

        return cell
    }
}
