//
//  AuthViewModel.swift
//  absenteeismify
//
//  Created by Guest Soleil on 10/14/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class AuthViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    @Published var accessToken: String = ""
    @Published var userEmail: String = ""
    private var authStateListener: AuthStateDidChangeListenerHandle?

    init() {
        // Listen for changes in the user's authentication state
        authStateListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            // Update the signed-in status based on whether the user is signed in or not
            self?.isSignedIn = user != nil
        }
    }
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { print("Unable to get the root view controller.");
            return }
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController, hint: nil, additionalScopes: ["https://www.googleapis.com/auth/gmail.send"]) { result, error in
          guard error == nil else {
            // ...
              print(error)
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
              
          else {
            // ...
              return
          }
            self.accessToken = result?.user.accessToken.tokenString ?? ""

            print(self.accessToken)
            
            

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error { print("Firebase sign-in error: \(error.localizedDescription)") }
                else { print("User is signed in with Firebase") } }
            do {
                self.fetchUserEmail()
            }
            catch {
                print("couldn't fetch email :(")
                return
            }
            
            
          // ...
        }
    }
    
    
    func fetchUserEmail() {
        let url = URL(string: "https://www.googleapis.com/gmail/v1/users/me/profile")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching user email: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let email = json["emailAddress"] as? String {
                    // Step 3: Update the userEmail property in the main thread
                    DispatchQueue.main.async {
                        self?.userEmail = email
                    }
                }
            } catch {
                print("Error parsing email response: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    
    // Sign out function
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
            print(isSignedIn)
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
