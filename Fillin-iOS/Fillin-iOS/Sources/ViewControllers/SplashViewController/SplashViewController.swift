//
//  SplashViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: - Properties
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//            if self.appDelegate?.isLogin == true {
//                self.presentToMain()
//            } else {
//                if UserDefaults.standard.object(forKey: Const.UserDefaultsKey.accessToken) != nil {
//                    self.presentToLogin()
//                } else {
//                    self.presentToOnboarding()
//                }
//            }
//        }
//    }
}

extension SplashViewController {
    // MARK: - Functions
    private func presentToMain() {
        let mainNavigationController = UINavigationController(rootViewController: HomeViewController())
        mainNavigationController.modalPresentationStyle = .fullScreen
        mainNavigationController.modalTransitionStyle = .crossDissolve
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    private func presentToLogin() {
        let loginNavigationController = UINavigationController(rootViewController: LoginViewController())
        loginNavigationController.modalPresentationStyle = .fullScreen
        loginNavigationController.modalTransitionStyle = .crossDissolve
        self.present(loginNavigationController, animated: true, completion: nil)
    }
    
    private func presentToOnboarding() {
        let onboardingNavigationController = UINavigationController(rootViewController: OnboardingViewController())
        onboardingNavigationController.modalPresentationStyle = .fullScreen
        onboardingNavigationController.modalTransitionStyle = .crossDissolve
        self.present(onboardingNavigationController, animated: true, completion: nil)
    }
}
