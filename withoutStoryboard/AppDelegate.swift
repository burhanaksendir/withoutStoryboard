//
//  AppDelegate.swift
//  withoutStoryboard
//
//  Created by yasin turkoglu on 30.06.2015.
//  Copyright (c) 2015 yasin turkoglu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    
    
    //xcode'da proje oluştururken single view application template'ini kullanıp default gelen stroyboard'ı siliyoruz.
    //fakat bu storyBoard'ı sildikten sonra uygulamamız build ettiğimizde çökecektir.
    //bunun nedeni de targets/info alanında yer alan Custom IOS Target Properties alanında tanımlı olan Main storyboard file base name set'idir.
    //dolayısıyla Main storyboard file base name satırını komple siliyoruz.
    
    //tabi ortada artık bir storyboard kalmadığı için window'u da manuel olarak tanımlamalıyız.
    var window: UIWindow? = UIWindow()
    //daha sonra programsal olarak oluşturuacağımız viewController'ımızı için mevcut viewController class'ımızı bir değişkene atıyoruz.
    var viewController: ViewController = ViewController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //öncelikle uygulamanın çalışacağı cihaza ait ekran ölçülerine ihtiyacımız var. Bu ölçüleri alıp bounds değişkenimize atıyoruz
        let bounds:CGRect = UIScreen.mainScreen().bounds
        //window ölçülerini cihazımızın ekran ölçülerine set ediyoruz.
        self.window!.frame = bounds
        //şimdi sıra geldi viewController'ımızı rootViewController olarak window'un altına atmaya.
        self.window!.rootViewController = self.viewController
        //ve son olarak atadığımız rootViewController'ın window içerisinde görünmesini sağlamalıyız.
        self.window!.makeKeyAndVisible()
        //appDelegate içerisinde yapacağımız değişiklikler bu kadar artık window ve viewController'ımız programsal olarak yaratıldılar ve üzerlerinde çalışılmaya hazırlar.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

