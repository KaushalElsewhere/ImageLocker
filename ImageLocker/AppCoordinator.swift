//
//  AppCoordinator.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 27/05/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit

extension AppCoordinator: DashboardControllerDelegate{
    func dashboardController(vc: DashboardController, didSelectFolder folder: Model.Folder) {
        folderDetailController = FolderDetailController()
        folderDetailController.folder = folder
        navigationController.pushViewController(folderDetailController, animated: true)
    }
}

class AppCoordinator: NSObject {
    var window: UIWindow?
    
    var navigationController: UINavigationController!
    var dashController: DashboardController!
    var folderDetailController: FolderDetailController!
    
    
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
        dashController = DashboardController()
        dashController.delegate = self
        navigationController = UINavigationController(rootViewController: dashController)
        
        return navigationController

    }
    
    private func constructUnauthenticatedRootViewController() -> UIViewController {
        let controller = UIViewController() //OnBoardingController()
        //controller.delegate = self
        return controller
    }
    
}
