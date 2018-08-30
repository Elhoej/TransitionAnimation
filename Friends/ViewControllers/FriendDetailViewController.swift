//
//  FriendDetailViewController.swift
//  Friends
//
//  Created by Simon Elhoej Steinmejer on 30/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate
{
    let transitionAnimator = TransitionAnimator()
    private var interactionController: UIPercentDrivenInteractiveTransition?
    var friend: Friend?
    {
        didSet
        {
            guard let friend = friend else { return }
            profileImageView.image = friend.profileImage
            nameLabel.text = friend.name
            bioLabel.text = friend.bio
            title = friend.name
        }
    }
    var cell: FriendCell?
    
    let profileImageView: UIImageView =
    {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let nameLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    let bioLabel: UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        navigationController?.delegate = self
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer)
    {
        switch sender.state {
        case .began:
            let location = sender.location(in: view)
            if location.x < view.bounds.midX
            {
                interactionController = UIPercentDrivenInteractiveTransition()
                navigationController?.popViewController(animated: true)
            }
        case .changed:
            let translation = sender.translation(in: view)
            let percentageComplete = fabs(translation.x / view.bounds.width)
            interactionController?.update(percentageComplete)
        case .ended:
            if sender.velocity(in: view).x > 0
            {
                interactionController?.finish()
            }
            else
            {
                interactionController?.cancel()
            }
            interactionController = nil
        default:
            break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        transitionAnimator.cell = cell
        transitionAnimator.pushing = false
        return transitionAnimator
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        return interactionController
    }
    
    
    private func setupViews()
    {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(bioLabel)
        
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 200)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 20)
        
        bioLabel.anchor(top: nameLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 0)
    }
    
}




















