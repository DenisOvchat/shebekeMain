//
//  AppDelegate.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 04.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
import CoreData
import SocketIO
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var data=ProgramData()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        ShebekeSocketManager.sharedInstance.establishConnection()

        
        ServerManager.addServerManager(named:"main",domain:"http://188.225.38.189")
        
        
        
      /*
        let cookieJar = HTTPCookieStorage.shared
        let d = cookieJar.cookies(for:         URL(string: "http://188.225.38.189")!
)
        for cookie in d!{
            
           // if cookie.name == "MYNAME" {
                
                let cookieValue = cookie.value
            print("COOKIE name = \(cookie.commentURL)")

            print("COOKIE name = \(cookie.name)")

                print("COOKIE VALUE = \(cookieValue)")
           // }
        }
        
        loadHTTPCookies()*/

     /*
        let cookiesAreConfigured = methodThatChecksIfTheCookiesAreConfigured()
        if cookiesAreConfigured == true {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController : UIViewController = mainStoryboardIpad.instantiateViewControllerWithIdentifier("HomeVC") as HomeVC
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
        */
        
        // Override point for customization after application launch.
       /* let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        let navigationController = Controller(rootViewController: pageController)
        //view.backgroundColor = UIColor.red
        //show(navigationController, sender: nil)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()*/
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    //    saveCookies()

        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
     //   loadHTTPCookies()
        ShebekeSocketManager.sharedInstance.closeConnection()

        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        ShebekeSocketManager.sharedInstance.establishConnection()

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
      //  saveCookies()

        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
     //   self.saveContext()
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Shebeke")
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
        if #available(iOS 10.0, *) {
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
        } else {
            // Fallback on earlier versions
        }
       
    }

    
    func loadHTTPCookies() {
        
        if let cookieDict = UserDefaults.standard.value(forKey: "cookieArray") as?NSMutableArray {
            
            for c in cookieDict {
                
                let cookies = UserDefaults.standard.value(forKey: c as!String) as!NSDictionary
                let cookie = HTTPCookie(properties: cookies as![HTTPCookiePropertyKey: Any])
                
                HTTPCookieStorage.shared.setCookie(cookie!)
            }
        }
    }
    
    func saveCookies() {
        
        let cookieArray = NSMutableArray()
        if let savedC = HTTPCookieStorage.shared.cookies {
            for c: HTTPCookie in savedC {
                
                let cookieProps = NSMutableDictionary()
                cookieArray.add(c.name)
                cookieProps.setValue(c.name, forKey: HTTPCookiePropertyKey.name.rawValue)
                cookieProps.setValue(c.value, forKey: HTTPCookiePropertyKey.value.rawValue)
                cookieProps.setValue(c.domain, forKey: HTTPCookiePropertyKey.domain.rawValue)
                cookieProps.setValue(c.path, forKey: HTTPCookiePropertyKey.path.rawValue)
                cookieProps.setValue(c.version, forKey: HTTPCookiePropertyKey.version.rawValue)
                cookieProps.setValue(NSDate().addingTimeInterval(2629743), forKey: HTTPCookiePropertyKey.expires.rawValue)
                
                UserDefaults.standard.setValue(cookieProps, forKey: c.name)
                UserDefaults.standard.synchronize()
            }
        }
        
        UserDefaults.standard.setValue(cookieArray, forKey: "cookieArray")
    }
    
    func getMyId() -> Int?
    {
        return  data.myProfile?.id
        
    }
    
}




func addFriend(id:Int)
{
    let data = ["act":"add","friend_id":id] as [String : Any]
    
    
    
    ServerManager.shared(named: "main")?.POSTJSONRequestByAdding(postfix: "/friends", data: data, complititionHandler:  { (data:Data?, response:URLResponse?, error:Error?) in
        
        
        
        if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String]
        {
            
            if httpResponse.statusCode == 202
            {
                print(202)
                
            }
            
            
        }
        
    })
    
}

protocol SocketMessageDelegate:NSObjectProtocol
{
    func gotMessage(dataArray:[Any])

}




protocol SocketProtocol {
    func set()
}


class SocketManager:SocketProtocol
{
    
    var delegates : [String:Set<NSObject>] = [String:Set<NSObject>]()
        //= [String:[Int:socketMessageDelegate]]()
    static let sharedInstance = SocketManager()
    
    
    let socket = SocketIOClient(socketURL: URL(string: "http://188.225.38.189/im")!, config: [.log(false), .forcePolling(true)])
    
    func foo(_ dataSource: UITableViewDataSource) {
    }
    init()
    {
        
    }
    init(categories:[String]) {
        for category in categories
        {
            delegates[category] = Set<NSObject>()
        }
    }
    
    
    func addDelegate(delegate:SocketMessageDelegate, category:String)->Bool
    {
        
        var dels =  self.delegates[category]
        if dels != nil
        {
            
            dels?.insert(delegate as! NSObject)
            return true
        }
        else
        {
            return false
        }
    }
    
    func removeDelegate(delegate:SocketMessageDelegate, category:String)
    {
        var dels =  self.delegates[category]
        if dels != nil
        {
            dels?.remove(delegate as! NSObject)
        }
        else
        {
            return
        }
    }
    
    
    func set()
    {
        fatalError("Must Override")

    }
    
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    

}

class ShebekeSocketManager:SocketManager
{
    
   override func set()
    {
        
        self.socket.on("currentAmount") {data, ack in
            if let cur = data[0] as? Double {
                self.socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                    self.socket.emit("update", ["amount": cur + 2.50])
                }
                
                ack.with("Got your currentAmount", "dude")
            }
        }
        
        socket.on("gotMessage") { ( dataArray, ack) -> Void in
            if let neededDelegates = self.delegates["gotMessage"]
            {
                
                for delegate in neededDelegates
                {
                    (delegate as! SocketMessageDelegate).gotMessage(dataArray: dataArray as! [Any])
                }
                
            }
        }
        
        func connectToServerWithId(id: Int, completionHandler: (_ userList: [[String: AnyObject]]?) -> Void) {
            socket.emit("connectUser", id)
        }
        
        
        
    }
}

