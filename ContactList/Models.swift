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
    init(imageData: Data? = nil, name: String = "") {
        self.imageData = imageData
        self.name = name
    }
    static let example : [Person] = [Person(name: "Hansel"), Person(name: "Gretal")]
}
@Model
class Quirk {
    var descrip : String = ""
    var person : Person?
    init(descrip: String = "", person : Person? = nil) {
        self.descrip = descrip
        self.person = person
    }
}
