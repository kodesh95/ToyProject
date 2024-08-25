//
//  AppDelegate.swift
//  ToyProject
//
//  Created by jieunchoi on 8/12/24.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
//    var window: ToyWindowsController?
//  var window: FileListWindowController?
  var window: MainWindowController?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
//        print("App Start")
//        NSLog("App Start")
    window = .create()
    window?.showWindow(self)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
    
  }

  func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  // MARK: - Core Data stack
  // persistent container 초기화
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CoreData")

    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        print("초기화 - \(error)")
      }
    })
    return container
  } ()

  var context: NSManagedObjectContext {
    return self.persistentContainer.viewContext
  }


}
