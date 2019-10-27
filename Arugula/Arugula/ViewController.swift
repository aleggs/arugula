//
//  ViewController.swift
//  Arugula
//
//  Created by Alex on 10/25/19.
//  Copyright © 2019 Arugula. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController, SwipeableCardViewDataSource {
    
    
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        swipeableCardView?.dataSource = self

    }
    
    @IBAction func LoginPressed(_ sender: Any) {
        
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else{
            return
        }
        authUI?.delegate = self

        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth(),
        ]
        authUI?.providers = providers
        
        func application(_ app: UIApplication, open url: URL,
                         options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
            let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
          if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
          }
          // other URL handling goes here.
          return false
        }
        
        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
    }
 
    
    
}

extension ViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            //log error, reprompt login
            return
        }
        
        //authDataResult?.user.uid //user login identifier, pass to and from database
        performSegue(withIdentifier: "toWelcome", sender: self)
    }
}

extension ViewController {

    func numberOfCards() -> Int {
        return viewModels.count
    }

    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let viewModel = viewModels[index]
        let cardView = SampleSwipeableCard()
        cardView.viewModel = viewModel
        return cardView
    }

    func viewForEmptyCards() -> UIView? {
        return nil
    }

}


extension ViewController {

    var viewModels: [SampleSwipeableCellViewModel] {

        let hamburger = SampleSwipeableCellViewModel(title: "McDonalds",
                                                     subtitle: "Hamburger",
                                                     color: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0),
                                                     image: #imageLiteral(resourceName: "hamburger"))

        let panda = SampleSwipeableCellViewModel(title: "Panda",
                                                  subtitle: "Animal",
                                                  color: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "panda"))

        let puppy = SampleSwipeableCellViewModel(title: "Puppy",
                                                  subtitle: "Pet",
                                                  color: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "puppy"))

        let poop = SampleSwipeableCellViewModel(title: "Poop",
                                                  subtitle: "Smelly",
                                                  color: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "poop"))

        let robot = SampleSwipeableCellViewModel(title: "Robot",
                                                  subtitle: "Future",
                                                  color: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "robot"))

        let clown = SampleSwipeableCellViewModel(title: "Clown",
                                                  subtitle: "Scary",
                                                  color: UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "clown"))

        return [hamburger, panda, puppy, poop, robot, clown]
    }

}


