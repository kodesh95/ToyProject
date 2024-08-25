//
//  FileModel.swift
//  ToyProject
//
//  Created by jieunchoi on 8/20/24.
//

import Foundation

class Attributes: Codable {
  var attriArr: [Attribute]
  
  init(_ attriArr: [Attribute]) {
    self.attriArr = attriArr
  }
}

class Attribute: Codable {

  var id: UUID
  var name: String // 파일 이름
  var size: Int64 // 파일 크기
  var kind: String // 파일 타입
  var creationDate: String // 생성일
  
  init(id: UUID, name: String, size: Int64, kind: String, creationDate: String) {
    self.id = id
    self.name = name
    self.size = size
    self.kind = kind
    self.creationDate = creationDate
  }
  
  init(name: String, size: Int64, kind: String, creationDate: String) {
    self.id = UUID()
    self.name = name
    self.size = size
    self.kind = kind
    self.creationDate = creationDate
  }
}

