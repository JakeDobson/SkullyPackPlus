//  MessagesViewController.swift
//  Skully Pack Plus
//  Created by Jacob Dobson on 6/6/17.
//  Copyright © 2017 Jacob Dobson. All rights reserved.
import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
	var vc: UIViewController! = nil
    //life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        self.present(with: self.presentationStyle)
    }
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        //called after extension transitions to new presentation style
        super.didTransition(to: presentationStyle)
        self.present(with: presentationStyle)
    }
    private func present(with presentationStyle:MSMessagesAppPresentationStyle) {
        //remove any existing child controllers
		for child in childViewControllers {
			child.willMove(toParentViewController: nil)
			child.view.removeFromSuperview()
			child.removeFromParentViewController()
		}
        switch presentationStyle {
        case .compact:
            vc = UIStoryboard(name: "MainInterface", bundle: nil).instantiateViewController(withIdentifier: String(describing: StickerCollectionVC.self)) as! StickerCollectionVC
            break
        case .expanded:
            vc = UIStoryboard(name: "MainInterface", bundle: nil).instantiateViewController(withIdentifier: String(describing: ExpandedView.self)) as! ExpandedView
            break
		default: break
		}
        //embed new controller
		addChildViewController(vc)
		
		vc.view.frame = view.frame
		vc.view.translatesAutoresizingMaskIntoConstraints = true
		view.addSubview(vc.view)
		
		vc.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vc.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vc.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
        vc.didMove(toParentViewController: self)
    }
}
