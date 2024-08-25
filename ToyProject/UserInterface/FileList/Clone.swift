//
//  Clone.swift
//  ToyProject
//
//  Created by jieunchoi on 8/23/24.
//

import Foundation

//class FileListViewModel: NSObject {
//
//
//
//  let fileManager: FileManager = FileManager.default
//  let context = OperationPersistenceController.shared
//
////  let xpcService = XPCService.init()
//
////  static let pathURL: URL = URL(fileURLWithPath: "\(NSHomeDirectory())/test")
//
//  @Published var dataSource: Attributes = .init(attiArr: [])
//
//  override init() {
//    super.init()
//  }
//
//  // MARK: 파일리스트 검색
//  func searchFileList(_ dir: String) {
//
//    // Attribute타입의 배열을 초기화 (중복된 데이터 저장방지 기능)
//    dataSource = .init(attiArr: [])
//
//    // 현재 경로 문자열 -> URL
//    let pathURL: URL = URL(fileURLWithPath: dir)
//
//    Task {
//
//      // enumerator가 FileManager.DirectoryEnumerator 타입의 객체
//      // URL 로 캐스팅해서 사용
//      // URL 자체는 아니지만 디렉토리를 탐색하는데 사용되는 객체이다.
//      let enumerator = fileManager.enumerator(at: pathURL, includingPropertiesForKeys: [.isDirectoryKey])
//      // isDirectoryKey: 항목이 디렉토리인지 여부를 확인하는 속성입니다.
//
//      while let eachDir = enumerator?.nextObject() as? URL {
//
//        // 경로가 존재하면
//        if fileManager.fileExists(atPath: eachDir.path) {
//          // dataSource에 정보저장 & 파일정보 검색
//          if let attribute = try? await getFileInfo(fullDirectory: eachDir.path) {
//            dataSource.attiArr.append(attribute)
//          }
//        } else {
//          NSLog("해당 디렉토리가 존재하지 않습니다.")
//        }
//      }//while
//    }//Task
//  }//searchFileList
//
//  // MARK: core data에 있는 모든 데이터 불러오기
//  func getAllList() {
//
//    // Attribute타입의 배열을 초기화 (중복된 데이터 저장방지 기능)
//    dataSource = .init(attiArr: [])
//
//    // NSManagedObjectContext에서 NSManagedObjectContext가져온 것
//    let context = OperationPersistenceController.shared.mainContext
//
//    let fetchedDatas = FileInfo.fetchFileInfo(context: context)
//
//    let attributes = fetchedDatas.compactMap { eachInfo -> Attribute? in
//      guard let id = eachInfo.id,
//        let name = eachInfo.name,
//        let kind = eachInfo.kind,
//        let creationDate = eachInfo.creationDate else {
//        return nil
//      }
//
//      return Attribute(id: id,
//                       name: name,
//                       size: eachInfo.size,
//                       kind: kind,
//                       creationDate: creationDate)
//
//    }
//
//    dataSource = Attributes(attiArr: attributes)
//  }
//
////  func getAllList() {
////    dataSource = ToyXPCManager.shared.fetchAll(context.mainContext)
////  }
//
//  // CoreData 에 저장하기
//  func saveToCoreData() {
//    do {
//      try context.mainContext.save()
//      print("저장 성공")
//    } catch {
//      context.mainContext.rollback()
//    }
//  }
//
//
//  private func getFileInfo(fullDirectory: String) async throws -> Attribute? {
//
//    let attributes = try fileManager.attributesOfItem(atPath: fullDirectory)
//
//    // 파일 타입을 해당 카테고리로 분류해주기
//    var fileKind: String = "unknown"
//
//    if let fileType = attributes[.type] as? FileAttributeType {
//      fileKind = categorize(fileType)
//    }
//
//    // 생성일, 사이즈 타입 맞춰주기
//    guard let fileDate = attributes[.creationDate] as? Date,
//      let size = attributes[.size] as? Int64 else {
//      return nil
//    }
//    let creationDate = fileDate.toString(format: "yyyy-MM-DD HH:mm:ss", timeZone: .current)
//
//    // Attribute 객체 생성
//    let attribute: Attribute = .init(name: fullDirectory,
//                                     size: size,
//                                     kind: fileKind,
//                                     creationDate: creationDate)
//    /*
//    * 중복제거 코드 - 권장하지 않는 코드
//
//    guard FileInfo.fetchFileInfo(context: context).filter({ $0.name == attribute.name.precomposedStringWithCanonicalMapping }).count == 0 else {
//      return nil
//    }
//     */
//    // NSManagedObjectContext에서 NSManagedObjectContext가져온 것
//
//    // TODO: performAndWait 아직 잘 모르겠음
//    context.mainContext.performAndWait {
//      // NSManagedObjec 의 init()을 사용해서 모델 스키마에 값 할당해주기
//      let fileinfo = FileInfo(context: context.mainContext)
//      fileinfo.id = UUID()
//      fileinfo.creationDate = attribute.creationDate
//      fileinfo.kind = attribute.kind
//      fileinfo.size = attribute.size
//      fileinfo.name = attribute.name.precomposedStringWithCanonicalMapping // 한글 깨지는거 방지
//
//    }
//    return attribute
//  }
//
//  // 파일 타입 이쁘게 보여주기
//  private func categorize(_ type: FileAttributeType) -> String {
//    switch type {
//    case .typeDirectory:
//      return "Directory"
//    case .typeRegular:
//      return "file"
//    case .typeSymbolicLink:
//      return "symbolic link"
//    case .typeSocket:
//      return "socket"
//    case .typeCharacterSpecial:
//      return "character special file"
//    case .typeBlockSpecial:
//      return "block file"
//    default: break
//    }
//    return "unknown"
//  }
//
//
//
//
//}
