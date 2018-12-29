//
//  ViewController.swift
//  Mitter Starter
//
//  Created by Vedavyas Bhat on 10/12/18.
//  Copyright © 2018 mitter.io. All rights reserved.
//

import UIKit
import Mitter

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var channels = [ParticipatedChannel]()
    let cellReuseIdentifier = "channelCell"

    @IBOutlet
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        self.tableView.delegate = self
        self.tableView.dataSource = self

        //Set 0 height footer to hide empty rows
        tableView.tableFooterView = UIView(frame: .zero)

        // Fetch the list of channels and display
        appDelegate.mitter.channels.getChannelsForCurrentUser {
            result in
            switch result {
            case .success(let fetchedChannels):
                self.channels = fetchedChannels
                print("Received all channels for logged in user")
                self.tableView.reloadData()

            case .error:
                print("Couldn't fetch all channels for logged in user")
            }
        }
    }


    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!

        // set the text from the data model
        cell.textLabel?.text = self.channels[indexPath.row].channel.channelId

        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Opening channel \(channels[indexPath.row].channel.channelId)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let channelWindowViewController = storyboard.instantiateViewController(withIdentifier: "channelWindowView") as! ChannelWindowViewController
        channelWindowViewController.channelId = channels[indexPath.row].channel.channelId
        navigationController!.pushViewController(channelWindowViewController, animated: true)
    }
}

