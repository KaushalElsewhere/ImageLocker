//
//  AppCoordinator.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 27/05/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject {
    var window: UIWindow?
    
    // Need to maintain a reference to these coordinators so they don't get deallocated
    //private var createItemCoordinator: CreateItemCoordinator!
    //private var feedCoordinator: FeedCoordinator!
    
    private lazy var authenticatedViewController: UIViewController = self.constructAuthenticatedRootViewController()
    private lazy var unauthenticatedViewController: UIViewController = self.constructUnauthenticatedRootViewController()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
//        if AuthenticatedUser() != nil {
//            window?.rootViewController = authenticatedViewController
//        } else {
//            window?.rootViewController = unauthenticatedViewController
//        }
        
        window?.rootViewController = authenticatedViewController
        window?.makeKeyAndVisible()
    }
    
//    func onBoardingControllerDidAuthenticate(onBoardingController: OnBoardingController) {
//        window?.rootViewController = authenticatedViewController
//    }
    
    private func constructAuthenticatedRootViewController() -> UIViewController {
        let dashController = DashboardController()
        
        let dashNav = UINavigationController(rootViewController: dashController)
        
        return dashNav

    }
    
    private func constructUnauthenticatedRootViewController() -> UIViewController {
        let controller = UIViewController() //OnBoardingController()
        //controller.delegate = self
        return controller
    }
    
}
