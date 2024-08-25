//
//  FileInfo+.swift
//  ToyProject
//
//  Created by jieunchoi on 8/21/24.
//

import Foundation
import CoreData

extension FileInfo {
  static func fetchFileInfo(context: NSManagedObjectContext) -> [FileInfo] {
    let request: NSFetchRequest<FileInfo> = fetchRequest()
    return (try? context.fetch(request)) ?? []
  }
//  static func deleteAll(context: NSManagedObjectContext) {
//    let request: NSFetchRequest<FileInfo> = fetchRequest()
//    let delete = NSBatchDeleteResult(fetchRequest: request)
//    do {
//      try context.execute(delete)
//    } catch {
//      
//    }
//  }
  
}
