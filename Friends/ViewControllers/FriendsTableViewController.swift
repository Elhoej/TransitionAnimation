//
//  ViewController.swift
//  Friends
//
//  Created by Simon Elhoej Steinmejer on 30/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

struct Friend {
    var name: String
    var profileImage: UIImage
    var bio: String
}

class FriendsTableViewController: UITableViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate
{
    let friends = [Friend(name: "Dr. Dre", profileImage: #imageLiteral(resourceName: "dre"), bio: "I love the new technology. New things give you a reason to want to go to the studio. New challenges mean you have to keep up, you know?"), Friend(name: "Drake", profileImage: #imageLiteral(resourceName: "drake"), bio: "Trigger fingers turn to Twitter fingers.")]
    private let cellId = "friendCell"
    var selectedCell: FriendCell?
    let transitionAnimator = TransitionAnimator()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.register(FriendCell.self, forCellReuseIdentifier: cellId)
        title = "Friends"
        navigationController?.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FriendCell
        let friend = friends[indexPath.row]
    
        cell.nameLabel.text = friend.name
        cell.profileImageView.image = friend.profileImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendCell else { return }
        selectedCell = cell
        let friend = friends[indexPath.row]
        let friendDetailViewController = FriendDetailViewController()
        friendDetailViewController.friend = friend
        friendDetailViewController.cell = cell
        friendDetailViewController.transitioningDelegate = self
        navigationController?.pushViewController(friendDetailViewController, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        guard let cell = selectedCell else { return nil }
        transitionAnimator.cell = cell
        transitionAnimator.pushing = true
        return transitionAnimator
    }
}






















