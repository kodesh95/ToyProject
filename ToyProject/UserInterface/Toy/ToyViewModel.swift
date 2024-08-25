//
//  ToyViewModel.swift
//  ToyProject
//
//  Created by jieunchoi on 8/19/24.
//

/*
 비즈니스 로직: 데이터를 처리하고, 필요시 Model로부터 데이터를 받아와 가공하여 ViewController에 전달합니다.
 데이터 바인딩: View와 연결된 프로퍼티를 가지고 있으며, 데이터가 변경될 때 View를 업데이트할 수 있도록 합니다.
 Model과의 통신: Model 계층과 통신하며, 데이터를 저장하거나 불러옵니다.
 UI와는 무관한 코드: ViewModel은 UI 요소에 대한 참조를 가지지 않으며, 순수하게 데이터와 비즈니스 로직만을 다룹니다.
 */

import Foundation
import Combine
struct ToyDTO: Codable {
    var date: Date
    var contents: String
}
struct ToyDTOs: Codable {
    var toyArr: [ToyDTO]
}

class ToyViewModel: NSObject {

  // FileManager
  let fileManager: FileManager = FileManager.default

  // NSHomeDirectory : 사용자의 홈 디렉토리를 반환
  // 경로 URL
  static let toyPathURL: URL = URL(fileURLWithPath: "\(NSHomeDirectory())/toytest")


  // input data를 저장할 ToyDTO를 원소로 가지는 빈배열 선언
  @Published var dataSource: ToyDTOs = .init(toyArr: [])



  // ToyViewModel 의 인스턴스 생성
  override init() {
    super.init()
    //loadDataFromFile()
  }

  // toyPath 에서 데이터를 읽어서 dataSource에 저장하기
  func loadDataFromFile() {
    Task {
      do {
        let items = try await fetchDataFromFile()
        await MainActor.run {
          self.dataSource = items
        }
      } catch {
        NSLog("Load Error : \(error)")
      }
    }
  }

  // ToyDTOs 를 반환하는 비동기 함수
  private func fetchDataFromFile() async throws -> ToyDTOs {
    // URL의 파일에서 data 가져오기
    let dataFromPath: Data = try Data(contentsOf: ToyViewModel.toyPathURL)
    // data를 ToyDTOs 타입으로 디코딩하기
    let items = try JSONDecoder().decode(ToyDTOs.self, from: dataFromPath)

    return items;
  }

  // input 버튼 클릭시 data 추가 처리
  func addToyItem(contents: String) {
    dataSource.toyArr.append(.init(date: Date(), contents: contents))
  }

  // save 버튼 클릭시 data -> encoding -> 파일에 저장
  func saveContents() {
    Task {
      do {
        let data = try JSONEncoder().encode(dataSource)
        try await saveDataToFile(data)
      } catch {
        NSLog("save Error \(error)")
      }
    }
  }

  // 파일에 저장하는 함수
  private func saveDataToFile(_ data: Data) async throws {
    try data.write(to: ToyViewModel.toyPathURL)
  }

  // remove 버튼 클릭시
  func removeToyItem(at index: Int) {
    guard index >= 0 && index < dataSource.toyArr.count else {
      return
    }
    dataSource.toyArr.remove(at: index)
  }


}
