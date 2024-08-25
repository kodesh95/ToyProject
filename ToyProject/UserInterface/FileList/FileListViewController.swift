//
//  FileEx1.swift
//  ToyProject
//
//  Created by jieunchoi on 8/14/24.
//

import Foundation
import AppKit
import Cocoa
import Combine


class FileListViewController: NSViewController {

  private var viewModel: FileListViewModel!

  private var cancellables = Set<AnyCancellable>()
  // TableView 연결
  @IBOutlet weak var tableView: NSTableView!
  // 사용자로부터 입력받는 디렉토리
  @IBOutlet weak var inputDir: NSTextField!



  override func viewDidAppear() {
    super.viewDidAppear()

    viewModel = FileListViewModel()

//    tableView.dataSource = self
//    tableView.delegate = self

//    subscribe()

  }


  // 구독
//  func subscribe() {
//    viewModel.$dataSource.receive(on: DispatchQueue.main)
//      .sink { _ in
//      self.tableView.reloadData()
//    }
//      .store(in: &cancellables)
//  }

  //search 버튼 클릭 시
  @IBAction func searchBtn(_ sender: Any) {
    let dir = inputDir.stringValue
    viewModel.searchFileList(dir)
  }
  // load 버튼 클릭 시
  @IBAction func loadBtn(_ sender: Any) {
    //    viewModel.performFileListRequest() {
    //      print("완료?")
    //    }
    viewModel.getAllList()
  }
  // save 버튼 클릭 시
  @IBAction func saveBtn(_ sender: Any) {
    let dir = inputDir.stringValue
    viewModel.saveToCoreData()
  }
  
  
  
  
}
//
//extension FileListViewController: NSTableViewDataSource {
//  func numberOfRows(in tableView: NSTableView) -> Int {
//    return viewModel.dataSource.attiArr.count
//  }
//}
//
//extension FileListViewController: NSTableViewDelegate {
//  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//    guard let identifier = tableColumn?.identifier,
//      let cellView = tableView.makeView(withIdentifier: identifier, owner: nil) as? NSTableCellView
//      else { return nil }
//
//    switch tableColumn {
//    case tableView.tableColumns[0]:
//      cellView.textField?.stringValue = viewModel.dataSource.attiArr[row].name
//    case tableView.tableColumns[1]:
//      cellView.textField?.stringValue = viewModel.dataSource.attiArr[row].creationDate
//    case tableView.tableColumns[2]:
//      cellView.textField?.stringValue = viewModel.dataSource.attiArr[row].size.description + " byte"
//    case tableView.tableColumns[3]:
//      cellView.textField?.stringValue = viewModel.dataSource.attiArr[row].kind
//    default: break
//    }
//
//    return cellView
//  }
//  
//  
//  
//  
//}
