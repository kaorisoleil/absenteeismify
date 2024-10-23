//
//  absenteeismifyApp.swift
//  absenteeismify
//
//  Created by Guest Soleil on 7/24/24.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

      let providerFactory = AppCheckDebugProviderFactory()
      AppCheck.setAppCheckProviderFactory(providerFactory)


    return true
  }
func application(_ app: UIApplication,
                    open url: URL,
                    options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct absenteeismifyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var scheduleViewModel = ScheduleViewModel() 
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                 .environmentObject(scheduleViewModel)
        }
    }
}
