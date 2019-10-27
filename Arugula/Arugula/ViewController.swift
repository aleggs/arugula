//
//  ViewController.swift
//  Arugula
//
//  Created by Alex on 10/25/19.
//  Copyright © 2019 Arugula. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func LoginPressed(_ sender: Any) {
        
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else{
            return
        }
        authUI?.delegate = self
        

        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth(),
//          FUIEmailAuth.initAuthAuthUI(FUIAuth.defaultAuthUI(), signInMethod: FIREmailLinkAuthSignInMethod, forceSameDevice: false, allowNewEmailAccounts: true, actionCodeSetting: actionCodeSettings)
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
