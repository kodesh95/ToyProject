//
//  MainViewController.swift
//  ToyProject
//
//  Created by jieunchoi on 8/21/24.
//

import Foundation
import AppKit

class MainViewController: NSViewController {

  var fileListWindowController: FileListWindowController?
  var toyWindowsController: ToyWindowsController?

  override func viewDidLoad() {
    super.viewDidAppear()


  }

  @IBAction func goToFileListApp(_ sender: Any) {
    if fileListWindowController == nil {
      fileListWindowController = FileListWindowController.create()
    }
    fileListWindowController?.showWindow(self)
  }

  @IBAction func goToFirstApp(_ sender: Any) {
    if toyWindowsController == nil {
      toyWindowsController = ToyWindowsController.create()
    }
    toyWindowsController?.showWindow(self)
  }

}
