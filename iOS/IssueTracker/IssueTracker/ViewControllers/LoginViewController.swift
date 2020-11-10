//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by woong on 2020/10/28.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    // MARK: Properties
    
    private let clientID = ""
    private let clientSecret = ""
    var webAuthSession: ASWebAuthenticationSession?
    var token: String?

    @IBOutlet weak var loginProviderStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProviderLoginView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }
    
    // MARK: Methods
    
    func requestGitHubCode() {
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=\(scope)"
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
             // UIApplication.shared.open(url)
             // redirect to scene(_:openURLContexts:) if user authorized
            return
        }
        
        var callBackURLScheme = "IssueTracker-16://login"
        webAuthSession = ASWebAuthenticationSession.init(url: url, callbackURLScheme: callBackURLScheme, completionHandler: { [weak self] (callBack:URL?, error:Error?) in

            // handle auth response
            guard error == nil, let successURL = callBack else {
                return
            }
            
            if let code = callBack?.absoluteString.components(separatedBy: "=").last {
                self?.getGitHubAccessToken(for: code)
            }
        })
        
        webAuthSession?.presentationContextProvider = self
        webAuthSession?.start()
    }
    
    func getGitHubAccessToken(for code: String) {
        let url = URL(string: "https://github.com/login/oauth/access_token")!
        var request = URLRequest(url: url)
        let json = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "code": code
        ]
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch {
            debugPrint(error)
        }
        
        let session = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard error == nil else {
                debugPrint(error)
                return
            }
            
            if let response = response {
                print("response: \(response)")
            }
            
            
            self?.successLogic()
        }.resume()
    }
    
    func successLogic() {
        DispatchQueue.main.async {
            guard let mainVC = self.storyboard?.instantiateViewController(identifier: "MainTabBarController") as? UITabBarController else {
                print("Main is nil")
                return
            }
            
            self.view.window?.rootViewController = mainVC
        }
    }
    
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    @IBAction func touchedSignInWithGitHubButton(_ sender: UIButton) {
        requestGitHubCode()
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            guard let idToken = appleIDCredential.identityToken else {
                debugPrint("Token is Empty")
                return
            }
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            let tokenString = String(data: idToken, encoding: .utf8)
            if let token = tokenString {
                successLogic()
            }
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
//             self.saveUserInKeychain(userIdentifier)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            // self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
            
            // FIXME: 다음 화면으로 넘겨줘
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                 self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
//        guard let viewController = self.presentingViewController as? ResultViewController
//            else { return }
//
//        DispatchQueue.main.async {
//            viewController.userIdentifierLabel.text = userIdentifier
//            if let givenName = fullName?.givenName {
//                viewController.givenNameLabel.text = givenName
//            }
//            if let familyName = fullName?.familyName {
//                viewController.familyNameLabel.text = familyName
//            }
//            if let email = email {
//                viewController.emailLabel.text = email
//            }
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
