//
//  TransitionAnimator.swift
//  Friends
//
//  Created by Simon Elhoej Steinmejer on 30/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    var cell: FriendCell?
    var pushing = false
    
//    init(cell: FriendCell?, pushing: Bool)
//    {
//        self.cell = cell
//        self.pushing = pushing
//    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        if pushing
        {
            handlePushAnimation(transitionContext: transitionContext)
        }
        else
        {
            handlePopAnimation(transitionContext: transitionContext)
        }
    }
    
    private func handlePopAnimation(transitionContext: UIViewControllerContextTransitioning)
    {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? FriendDetailViewController, let toVC = transitionContext.viewController(forKey: .to) as? FriendsTableViewController, let toView = transitionContext.view(forKey: .to), let cell = cell else { return }
        
        let containerView = transitionContext.containerView
        
        toView.frame = transitionContext.finalFrame(for: toVC)
        toView.alpha = 0
        containerView.addSubview(toView)
        
        let sourceLabel = fromVC.nameLabel
        let destinationLabel = cell.nameLabel
        sourceLabel.alpha = 0
        destinationLabel.alpha = 0
        
        let sourceImageView = fromVC.profileImageView
        let destinationImageView = cell.profileImageView
        sourceImageView.alpha = 0
        destinationImageView.alpha = 0
        
        let initialFrameLabel = containerView.convert(sourceLabel.bounds, from: sourceLabel)
        let labelToAnimate = UILabel(frame: initialFrameLabel)
        labelToAnimate.text = sourceLabel.text
        labelToAnimate.font = sourceLabel.font
        containerView.addSubview(labelToAnimate)
        
        let initialImageFrame = containerView.convert(sourceImageView.bounds, from: sourceImageView)
        let imageViewToAnimate = UIImageView(frame: initialImageFrame)
        imageViewToAnimate.image = sourceImageView.image
        imageViewToAnimate.contentMode = sourceImageView.contentMode
        imageViewToAnimate.clipsToBounds = true
        imageViewToAnimate.layer.masksToBounds = true
        containerView.addSubview(imageViewToAnimate)
        
        let duration = transitionDuration(using: transitionContext)
        
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            
            labelToAnimate.frame = containerView.convert(destinationLabel.bounds, from: destinationLabel)
            imageViewToAnimate.frame = containerView.convert(destinationImageView.bounds, from: destinationImageView)
            toView.alpha = 1
            imageViewToAnimate.layer.cornerRadius = 21.5
            
        }) { (completed) in
            
            labelToAnimate.removeFromSuperview()
            imageViewToAnimate.removeFromSuperview()
            
            sourceLabel.alpha = 1
            destinationLabel.alpha = 1
            sourceImageView.alpha = 1
            destinationImageView.alpha = 1
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    private func handlePushAnimation(transitionContext: UIViewControllerContextTransitioning)
    {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? FriendsTableViewController, let toVC = transitionContext.viewController(forKey: .to) as? FriendDetailViewController, let toView = transitionContext.view(forKey: .to), let cell = cell else { return }
        
        let containerView = transitionContext.containerView
        
        toView.frame = transitionContext.finalFrame(for: toVC)
        toView.alpha = 0
        containerView.addSubview(toView)
        
        let sourceLabel = cell.nameLabel
        let destinationLabel = toVC.nameLabel
        sourceLabel.alpha = 0
        destinationLabel.alpha = 0
        
        let sourceImageView = cell.profileImageView
        let destinationImageView = toVC.profileImageView
        sourceImageView.alpha = 0
        destinationImageView.alpha = 0
        
        let initialFrameLabel = containerView.convert(sourceLabel.bounds, from: sourceLabel)
        let labelToAnimate = UILabel(frame: initialFrameLabel)
        labelToAnimate.text = sourceLabel.text
        labelToAnimate.font = sourceLabel.font
        containerView.addSubview(labelToAnimate)
        
        let initialImageFrame = containerView.convert(sourceImageView.bounds, from: sourceImageView)
        let imageViewToAnimate = UIImageView(frame: initialImageFrame)
        imageViewToAnimate.image = sourceImageView.image
        imageViewToAnimate.contentMode = sourceImageView.contentMode
        imageViewToAnimate.clipsToBounds = true
        imageViewToAnimate.layer.cornerRadius = 21.5
        imageViewToAnimate.layer.masksToBounds = true
        containerView.addSubview(imageViewToAnimate)
        
        let duration = transitionDuration(using: transitionContext)
        
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            
            labelToAnimate.frame = containerView.convert(destinationLabel.bounds, from: destinationLabel)
            imageViewToAnimate.frame = containerView.convert(destinationImageView.bounds, from: destinationImageView)
            imageViewToAnimate.layer.cornerRadius = 0
            toView.alpha = 1
            
        }) { (completed) in
            
            labelToAnimate.removeFromSuperview()
            imageViewToAnimate.removeFromSuperview()
            
            sourceLabel.alpha = 1
            destinationLabel.alpha = 1
            sourceImageView.alpha = 1
            destinationImageView.alpha = 1
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}






