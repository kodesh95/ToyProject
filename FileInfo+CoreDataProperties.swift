//
//  FileInfo+CoreDataProperties.swift
//  ToyProject
//
//  Created by jieunchoi on 8/22/24.
//
//

import Foundation
import CoreData


extension FileInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FileInfo> {
        return NSFetchRequest<FileInfo>(entityName: "FileInfo")
    }

    @NSManaged public var creationDate: String?
    @NSManaged public var id: UUID?
    @NSManaged public var kind: String?
    @NSManaged public var name: String?
    @NSManaged public var size: Int64

}

extension FileInfo : Identifiable {

}

