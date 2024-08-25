//
//  OperationPersistenceController.swift
//  ToyProject
//
//  Created by jieunchoi on 8/21/24.
//

import Foundation
import CoreData

struct OperationPersistenceController {
  static let shared = OperationPersistenceController()

  // 1. container 에서 context 를 가져온다.
  let container: NSPersistentContainer
  var mainContext: NSManagedObjectContext { container.viewContext }


  // 1-1. 초기화
  init() {
    container = NSPersistentContainer(name: "CoreData")
    
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy // in-memory와 영구 저장소 merge 충돌: in-memory우선
    container.viewContext.shouldDeleteInaccessibleFaults = true // 접근 불가의 결함들을 삭제할 수 있게끔 설정
    container.viewContext.automaticallyMergesChangesFromParent = true // parent의 context가 바뀌면 자동으로 merge되는 설정

    container.loadPersistentStores(completionHandler: {
      _, error in
      if let error = error as NSError? {
        print("!! 초기화 중 에러발생 !!")
        print("error: \(error)")
        print("error: \(error.userInfo)")
      }
    })
   
  }
  // TODO: container 커스텀 코드 추가하도록 하자
  

  
}
