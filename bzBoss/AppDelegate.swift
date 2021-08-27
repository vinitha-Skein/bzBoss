//
//  AppDelegate.swift
//  bzBoss
//
//  Created by Vinitha on 29/06/21.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseAuth


@available(iOS 13.0, *)
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        let storyboard:UIStoryboard = UIStoryboard(name: "Main1", bundle: nil)
        
//        let loginPage = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
//        self.window?.rootViewController = loginPage
        
//        let viewcontroller: OnboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
//        viewcontroller.modalTransitionStyle = .crossDissolve
//
//        let navController:UINavigationController = UINavigationController.init(rootViewController: viewcontroller)
//
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
        
//        let viewcontroller: ShopDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
//        viewcontroller.modalTransitionStyle = .crossDissolve
//
//        let navController:UINavigationController = UINavigationController.init(rootViewController: viewcontroller)
//
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
        
        if UserDefaults.standard.bool(forKey: "IS_LOGGED_IN"){
        gotoHome()
        } else {
        gotoOnboardingScreen()
        }
        return true
    }
    func gotoHome() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main1", bundle: nil)
        let viewcontroller: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        viewcontroller.modalTransitionStyle = .crossDissolve
        let navController:UINavigationController = UINavigationController.init(rootViewController: viewcontroller)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func gotoOnboardingScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main1", bundle: nil)
        let viewcontroller: OnboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        viewcontroller.modalTransitionStyle = .crossDissolve
        
        let navController:UINavigationController = UINavigationController.init(rootViewController: viewcontroller)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "bzBoss")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

