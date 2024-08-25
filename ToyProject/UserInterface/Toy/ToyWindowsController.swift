//
//  ToyWindowsController.swift
//  ToyProject
//
//  Created by jieunchoi on 8/12/24.
//

import Foundation
import AppKit


class ToyWindowsController: NSWindowController, NSWindowDelegate {
    
    static func create() -> ToyWindowsController {
        let storyboard = NSStoryboard(name: "ToyStoryboard", bundle: nil)
        let window: ToyWindowsController = storyboard.instantiateController(identifier: "ToyWindowsController")
        window.contentViewController = storyboard.instantiateController(identifier: "ToyViewController")
      
      window.window?.delegate = window // 창에 대한 이벤트를 감지하기 위한 delegate
        return window
    }

    
    
}

