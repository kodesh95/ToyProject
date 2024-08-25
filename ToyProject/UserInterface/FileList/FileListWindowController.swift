//
//  FileListWindowController.swift
//  ToyProject
//
//  Created by jieunchoi on 8/20/24.
//

import Foundation
import AppKit

class FileListWindowController: NSWindowController {
  
  static func create() -> FileListWindowController {
    
    let storyboard = NSStoryboard(name: "FileListStoryboard", bundle: nil)
    
    let window: FileListWindowController = storyboard.instantiateController(identifier: "FileListWindowController")
    
    let viewControl: FileListViewController = storyboard.instantiateController(identifier: "FileListViewController")
    window.contentViewController = viewControl
    
    return window
    
  }
  
}
