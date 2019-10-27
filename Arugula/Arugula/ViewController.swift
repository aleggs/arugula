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

        let abeLincoln = SampleSwipeableCellViewModel(title: "Abe Lincoln",
                                                     subtitle: "Spanish beginner :)",
                                                     color: UIColor(red:0.2, green:0.61, blue:0.31, alpha:1.0),
                                                     image: #imageLiteral(resourceName: "abeLincoln"))

        let johnDenero = SampleSwipeableCellViewModel(title: "John Denero",
                                                  subtitle: "Python, expert",
                                                  color: UIColor(red:0.3, green:0.64, blue:0.45, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "johnDenero"))

        let thomasJefferson = SampleSwipeableCellViewModel(title: "TJ",
                                                  subtitle: "French, expert",
                                                  color: UIColor(red:0.3, green:0.85, blue:0.49, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "thomasJefferson"))

        let johnAdams = SampleSwipeableCellViewModel(title: "John Adams",
                                                  subtitle: "Spanish beginner :O",
                                                  color: UIColor(red:0.3, green:0.52, blue:0.38, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "johnAdams"))

        let georgeWashington = SampleSwipeableCellViewModel(title: "George Washington",
                                                  subtitle: "Diplomacy expert",
                                                  color: UIColor(red:0.30, green:0.99, blue:0.6, alpha:1.0),
                                                  image: #imageLiteral(resourceName: "georgeWashington"))


        return [abeLincoln, johnDenero, thomasJefferson, johnAdams, georgeWashington]
    }

}


