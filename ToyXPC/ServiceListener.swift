//
//  XPCServiceListener.swift
//  ToyProject
//
//  Created by jieunchoi on 8/23/24.
//

import Foundation

//  XPC 서비스의 구체적인 기능을 정의
class ServiceListener: NSObject {

  private let service: ToyXPCService

  override init() {
    service = ToyXPCService()
    super.init()
  }

  func start() {
    // NSXPCListener 리스너 생성 : 연결 수락 역할
    let listener = NSXPCListener.service()
    // ServiceListener클래스가 NSXPCListenerDelegate 프로토콜을 준수하도록
    // 연결 관리 역할을 하도록 설정
    listener.delegate = self
    // 리스너 활성화
    // 활성화 후 들어오는 연결을 수락할 수 있음
    listener.resume()

  }
}

// MARK: 프로토콜을 준수함을 선언하는 확장
// ServiceListener 클래스가 들어오는 XPC 클라이언트 연결을 어떻게 처리할지를 정의
extension ServiceListener: NSXPCListenerDelegate {
  
  // 새로운 클라이언트 연결 요청이 들어올 때마다 호출
  // 들어온 요청을 수락 여부 결정
  func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
    
    // 연결이 무효화될 때 호출
    newConnection.invalidationHandler = {
      
    }
    // 연결이 중단될 때 호출
    newConnection.interruptionHandler = {
      
    }
    
    //  이 연결을 통해 사용할 수 있는 인터페이스를 정의
    newConnection.exportedInterface = NSXPCInterface(with: ToyXPCProtocol.self)
    //  Interface에서 정의된 메서드를 실제로 구현하는 객체를 지정
    newConnection.exportedObject = service
    // 활성화
    // 활성화 후 클라이언트 요청을 서비스 객체로 전달 가능
    newConnection.resume()
    return true
  }
  
  
}

