//
//  ToyXPCManager.swift
//  ToyXPC
//
//  Created by jieunchoi on 8/23/24.
//

import Foundation
import CoreData

final class ToyXPCManager: NSObject, ObservableObject {
  static let shared = ToyXPCManager()

  private var xpcConnection: NSXPCConnection?

  private var proxy: ToyXPCProtocol? {

    let errorHandler: (Error) -> Void = { error in
      print("[Toy] proxy error RealTime")
    }

    // 기존 xpcConnection 이 있는 경우
    // xpcConnection.remoteObjectProxyWithErrorHandler(errorHandler)를 호출하여 프록시 객체를 반환
    // 이 프록시는 CFServiceProtocol을 준수하는 원격 객체에 대한 프록시
    if let xpcConnection = xpcConnection {
      return xpcConnection.remoteObjectProxyWithErrorHandler(errorHandler) as? ToyXPCProtocol
    } else {
      // 기존 xpcConnection이 없는 경우
      // 새로운 XPC 연결 생성
      let connection = NSXPCConnection(serviceName: toyServiceName) // ???
      // protocol 지정
      connection.remoteObjectInterface = NSXPCInterface(with: ToyXPCProtocol.self)

      // 연결이 무효화되었을 때
      connection.invalidationHandler = {
        print("[Toy] connection invalidated")
        // 연결을 다시 시작하려고 시도
        self.toyServiceStart()
      }
      // 연결이 중단되었을 때
      connection.interruptionHandler = {
        print("[Toy] connection interrupted")
        // 연결을 다시 시작하려고 시도
        self.toyServiceStart()
      }

      // 커넥션 활성화
      connection.resume()

      // 멤버변수에 새로운 커넥션 할당
      xpcConnection = connection

      // xpcConnection.remoteObjectProxyWithErrorHandler(errorHandler)를 호출하여 프록시 객체를 반환
      return connection.synchronousRemoteObjectProxyWithErrorHandler(errorHandler) as? ToyXPCProtocol
    }
  }


  private func toyServiceStart() {
    proxy?.initializeEngine()
  }
  // 파일리스트 검색
  func searchFileList(dir: String) {
    // service에 구현된 메소드 호출
    proxy?.searchFileList(path: dir, completion: { dir in
      print(dir)
    })
  }

  
  public func fetchAll() {
//    var result: Attributes?
//
//    proxy?.fetchAll(context: context, completion: { item in
//      let fetchedDatas = FileInfo.fetchFileInfo(context: item)
//
//      let datas = fetchedDatas.compactMap { eachInfo -> Attribute? in
//        guard let id = eachInfo.id,
//          let name = eachInfo.name,
//          let kind = eachInfo.kind,
//          let creationDate = eachInfo.creationDate else {
//          return nil
//        }
//        return Attribute(id: id,
//                         name: name,
//                         size: eachInfo.size,
//                         kind: kind,
//                         creationDate: creationDate)
//      }// compacMap
//      result = datas
//      return result
//  }) // fetchAll

  }
}
