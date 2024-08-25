//
//  MainWindowController.swift
//  ToyProject
//
//  Created by jieunchoi on 8/21/24.
//

import Foundation
import AppKit

class MainWindowController: NSWindowController {
  
  static func create() -> MainWindowController {
      let storyboard = NSStoryboard(name: "MainStoryboard", bundle: nil)
      
    let window: MainWindowController = storyboard.instantiateController(identifier: "MainWindowController")
    
      window.contentViewController = storyboard.instantiateController(identifier: "MainViewController")
      return window
  }
  
}
