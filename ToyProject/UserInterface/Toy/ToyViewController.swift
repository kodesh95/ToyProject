//  ToyViewController.swift
//  ToyProject
//
//  Created by jieunchoi on 8/12/24.
//

import Foundation
import AppKit
import Cocoa
import Combine



/*
    MARK:   1. 텍스트 필드에 텍스트 입력
            2. 버튼 입력시 (트리거)
            3. 데이블 뷰에 전시
            
            4. 특정 경로에 있는 파일에 대한 리스트 만들기
            파일리스트 만들기
            폴더 리스트 만들기
            폴뎌 벌로 파일이 몇개가지고 있는지
            파일 생성일자는 어떤지
            제일큰 파일 사이즈는 얼마인지
            
            5. 파일 리스트를 만들어서 테이블 뷰에 보여준다.
            6. 파일 리스트를 만드는 방식을 MVVM형태로 개선한다
                Combine을 공부핼
            7. 파일 리스트를 뷰에도 추가하고 DB에도 추가한다.
            8. 추가한 DB에서 조건에 맞춰 select
            9. 추가한 DB에서 조건에 맞춰 delete
            10. db에서 처리할 사항을 xpc Service에 이관한다.
            11. xpc를 써봐야지???
            
 

*/

class ToyViewController: NSViewController {



  /*
   UI 요소와의 연결 (IBOutlet, IBAction): ViewController는 UI 요소
        (예: 버튼, 텍스트 필드 등)와 연결되어 있으며, 사용자의 상호작용을 처리합니다.
   ViewModel에 대한 참조 유지: ViewModel을 참조하고, ViewModel의 데이터를 바탕으로 UI를 업데이트합니다.
   ViewModel과의 바인딩: ViewModel에서 데이터를 받아와 UI를 업데이트하거나, 사용자 입력을 ViewModel에 전달하는 역할을 합니다.
   UI 업데이트: 데이터가 변경될 때 ViewModel로부터 알림을 받아 UI를 업데이트합니다
   */

  // viewModel
  private var viewModel: ToyViewModel!

  private var cancellables = Set<AnyCancellable>()
  // 입력 부분 연결
  @IBOutlet weak var inputTextField: NSTextField!
  // table view 연결
  @IBOutlet weak var tableView: NSTableView!

  override func viewDidAppear() {
    super.viewDidAppear()

    viewModel = ToyViewModel()

    tableView.dataSource = self
    tableView.delegate = self

    subscribe()
  }

  func subscribe() {
    // publisher dataSource가 방출하는 데이터를
    viewModel.$dataSource
    // 메인 쓰레드에서 처리하도록
    .receive(on: DispatchQueue.main)
    // _ 데이터를 무시하고 dataSource가 변경되면
    .sink { _ in
      // 테이블 뷰를 다시 그린다.
      self.tableView.reloadData()
    }
    // 메모리 누수 방지
    .store(in: &cancellables)
  }
  // input button
  @IBAction func buttonClick(_ sender: Any) {
    let content = inputTextField.stringValue
    viewModel.addToyItem(contents: content)
  }

  // 파일로 저장 버튼
  @IBAction func saveContents(_ sender: Any) {
    viewModel.saveContents()
  }

  // 삭제 버튼
  @IBAction func removeButton(_ sender: Any) {
    let selectedRow = tableView.selectedRow
    viewModel.removeToyItem(at: selectedRow)
  }

  // load button
  @IBAction func loadButton(_ sender: Any) {
    viewModel.loadDataFromFile()
  }



}

extension ToyViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return viewModel.dataSource.toyArr.count
  }
}

extension ToyViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    guard
      let identifier = tableColumn?.identifier,
      let cellView = tableView.makeView(withIdentifier: identifier, owner: nil) as? NSTableCellView
      else {
      return nil
    }

    switch tableColumn {
    case tableView.tableColumns[0]:
      cellView.textField?.stringValue = viewModel.dataSource.toyArr[row].date.description
    case tableView.tableColumns[1]:
      cellView.textField?.stringValue = viewModel.dataSource.toyArr[row].contents
    default:
      break
    }

    return cellView
  }

}

// MARK: 2
//class ToyViewController: NSViewController {
//
//    // FileManager
//    let fileManager: FileManager = FileManager.default
//
//    static let toyPath: String = "\(NSHomeDirectory())/firsttest"
//
//
//
//    private var dataSource: ToyDTOs = .init(toyArr: [])
//
//
//    // 입력 부분 연결
//    @IBOutlet weak var inputTextField: NSTextField!
//    // table view 연결
//    @IBOutlet weak var tableView: NSTableView!
//
//    override func viewDidAppear() {
//        super.viewDidAppear()
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//    // input button
//    @IBAction func buttonClick(_ sender: Any) {
//        NSLog("InputText - \(inputTextField.stringValue)")
//
//        dataSource.toyArr.append(.init(date: Date(),
//                                       contents: inputTextField.stringValue))
//        tableView.reloadData()
//    }
//
//    // 파일로 저장 버튼
//    @IBAction func saveContents(_ sender: Any) {
//        do {
//            // encoding
//            let data = try JSONEncoder().encode(dataSource)
//            // 파일 즉시 생성
//            fileManager.createFile(atPath: ToyViewController.toyPath, contents: data)
//        } catch {
//            NSLog("save Error \(error)")
//        }
//    }
//    // 삭제 버튼
//    @IBAction func removeButton(_ sender: Any) {
//        let selectedRow = tableView.selectedRow
//
//        guard selectedRow >= 0 else {
//            NSLog("선택된 셀이 없습니다.")
//            return
//        }
//        dataSource.toyArr.remove(at: selectedRow)
//        tableView.reloadData()
//    }
//
//    // load button
//    @IBAction func loadButton(_ sender: Any) {
//
////        // 1
////        guard let data = fileManager.contents(atPath: ToyViewController.toyPath) else {
////            NSLog("savPath Load False")
////            return
////        }
////
//        // 2
//        let toyPathURL: URL = URL(fileURLWithPath: ToyViewController.toyPath)
//        do {
//            let dataFromPath: Data = try Data(contentsOf: toyPathURL)
//            let items = try JSONDecoder().decode(ToyDTOs.self, from: dataFromPath)
//            self.dataSource = items
//            tableView.reloadData()
//        } catch {
//            NSLog("saveItem Load Error \(error)")
//        }
//
//    }
//
//
//}
//
//extension ToyViewController: NSTableViewDataSource {
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return dataSource.toyArr.count
//    }
//}
//
//extension ToyViewController: NSTableViewDelegate {
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//
//        guard
//            let identifier = tableColumn?.identifier,
//            let cellView = tableView.makeView(withIdentifier: identifier, owner: nil) as? NSTableCellView
//            else {
//            return nil
//        }
//
//        switch tableColumn {
//        case tableView.tableColumns[0]:
//            cellView.textField?.stringValue = dataSource.toyArr [row].date.description
//        case tableView.tableColumns[1]:
//            cellView.textField?.stringValue = dataSource.toyArr[row].contents.description
//        default:
//            break
//        }
//
//        return cellView
//    }
//
//}


// MARK: 1
//class ToyViewController: NSViewController {
//
//    struct item: Codable {
//        var date: Date
//        var contents: String
//    }
//
//    @IBOutlet weak var inputTextField: NSTextField!
//    @IBOutlet weak var tableView: NSTableView!
//
//    private var dataSource: [item] = []
//
//    override func viewDidAppear() {
//        super.viewDidAppear()
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//
//    @IBAction func buttonClick(_ sender: Any) {
//        NSLog("InputText - \(inputTextField.stringValue)")
//        dataSource.append(.init(date: Date(), contents: inputTextField.stringValue))
//        tableView.reloadData()
//
//
//        do {
//            let data = try JSONEncoder().encode(dataSource)
//        } catch {
//
//        }
//
//    }
//}
//
//extension ToyViewController: NSTableViewDataSource {
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return dataSource.count
//    }
//}
//
//extension ToyViewController: NSTableViewDelegate {
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//
//        guard
//            let identifier = tableColumn?.identifier,
//            let cellView = tableView.makeView(withIdentifier: identifier, owner: nil) as? NSTableCellView
//        else {
//            return nil
//        }
//
//        switch tableColumn {
//        case tableView.tableColumns[0]:
//            cellView.textField?.stringValue = dataSource[row].date.description
//        case tableView.tableColumns[1]:
//            cellView.textField?.stringValue = dataSource[row].contents
//        default:
//            break
//        }
//
//        return cellView
//    }
//
//}
