//
//  ToyXPCProtocol.swift
//  ToyXPC
//
//  Created by jieunchoi on 8/22/24.
//

import Foundation
import CoreData

let toyServiceName = "com.your.app.ToyProject.ToyXPC"
/// The protocol that this service will vend as its API. This protocol will also need to be visible to the process hosting the service.
@objc protocol ToyXPCProtocol {
    
  func initializeEngine()
  // 디렉토리의 모든 하위 요소 가져오기 (FileManager)
  func searchFileList(path: String,completion: @escaping (String) -> Void)
  
  // CoreData에 저장된 데이터 모두 fetch -> tableView
  func fetchAll(completion: @escaping () -> Void)
  
  // input 버튼 클릭시 하위 디렉토리 정보 -> CoreData
  func saveToCoreData(completion: @escaping () -> Void)
}

/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:

     connectionToService = NSXPCConnection(serviceName: "com.your.app.ToyProject.ToyXPC")
     connectionToService.remoteObjectInterface = NSXPCInterface(with: ToyXPCProtocol.self)
     connectionToService.resume()

 Once you have a connection to the service, you can use it like this:

     if let proxy = connectionToService.remoteObjectProxy as? ToyXPCProtocol {
         proxy.performCalculation(firstNumber: 23, secondNumber: 19) { result in
             NSLog("Result of calculation is: \(result)")
         }
     }

 And, when you are finished with the service, clean up the connection like this:

     connectionToService.invalidate()
*/
