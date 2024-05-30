//
//  Models.swift
//  ContactList
//
//  Created by Conner Yoon on 5/27/24.
//

import Foundation
import SwiftData
@Model
class Person {
    @Attribute(.externalStorage) var imageData : Data?
    var name : String = ""
    @Relationship(deleteRule: .nullify, inverse: \Quirk.person) var quirks : [Quirk] = []
    init(imageData: Data? = nil, name: String = "", quirks : [Quirk] = []) {
        self.imageData = imageData
        self.name = name
        self.quirks = quirks
    }
    static let example : [Person] = [Person(name: "Hansel", quirks: Quirk.example), Person(name: "Gretal")]
}
@Model
class Quirk {
    var descrip : String = ""
    var person : Person?
    init(descrip: String = "", person : Person? = nil) {
        self.descrip = descrip
        self.person = person
    }
    static let example : [Quirk] = [Quirk(descrip: "Has a dog."), Quirk(descrip: "Speaks French.")]
}
