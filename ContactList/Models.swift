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
