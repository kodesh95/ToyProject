//
//  ToyXPC.swift
//  ToyXPC
//
//  Created by jieunchoi on 8/22/24.
//

import Foundation
import CoreData

/// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
class ToyXPCService: NSObject, ToyXPCProtocol {

  private let fileManager = FileManager.default

  @Published var dataSource: Attributes = .init([])

  func initializeEngine() {
    NSLog("Toy Service ReStart")
  }

  // MARK: 디렉토리의 모든 하위 요소 가져오기
  func searchFileList(path: String, completion: @escaping (String) -> Void) {
    Task {
      let pathURL = URL(fileURLWithPath: path)
      let enumerator = fileManager.enumerator(at: pathURL, includingPropertiesForKeys: [.isDirectoryKey])

      while let eachDir = enumerator?.nextObject() as? URL {
        if fileManager.fileExists(atPath: eachDir.path) {
          if let attribute = try? await getFileInfo(fullDirectory: path) {
            dataSource.attriArr.append(attribute)
          }
        } else {
          NSLog("해당 디렉토리가 존재하지 않습니다.")
        }
      }
    }
    completion(path)
  }

  // MARK: core data에 있는 모든 데이터 불러오기
  func fetchAll(completion: @escaping () -> Void) {
    completion()
  }

  // MARK: core data에 데이터 저장하기
  func saveToCoreData(completion: @escaping () -> Void) {
    completion()
  }


}

extension ToyXPCService {

  private func getFileInfo(fullDirectory: String) async throws -> Attribute? {

    let attributes = try fileManager.attributesOfItem(atPath: fullDirectory)

    // 파일 타입을 해당 카테고리로 분류해주기
    var fileKind: String = "unknown"

    if let fileType = attributes[.type] as? FileAttributeType {
      fileKind = categorize(fileType)
    }

    // 생성일, 사이즈 타입 맞춰주기
    guard let fileDate = attributes[.creationDate] as? Date,
      let size = attributes[.size] as? Int64 else {
      return nil
    }
    let creationDate = fileDate.toString(format: "yyyy-MM-DD HH:mm:ss", timeZone: .current)

    // Attribute 객체 생성
    let attribute: Attribute = .init(name: fullDirectory,
                                     size: size,
                                     kind: fileKind,
                                     creationDate: creationDate)

    return attribute

  }

  private func categorize(_ type: FileAttributeType) -> String {
    switch type {
    case .typeDirectory:
      return "Directory"
    case .typeRegular:
      return "file"
    case .typeSymbolicLink:
      return "symbolic link"
    case .typeSocket:
      return "socket"
    case .typeCharacterSpecial:
      return "character special file"
    case .typeBlockSpecial:
      return "block file"
    default: break
    }
    return "unknown"
  }
}
