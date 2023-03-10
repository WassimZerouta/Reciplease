//
//  SecureCoding.swift
//  Reciplease
//
//  Created by Wass on 09/03/2023.
//

import Foundation

class MyTestClass: NSSecureCoding {

    var food: String = ""


    // Make sure you add this property
    static var supportsSecureCoding: Bool = true

    required init?(coder: NSCoder) {
        // NSCoding
        //name = coder.decodeObject(forKey: "name") as? String ?? ""
        //last_name = coder.decodeObject(forKey: "last_name") as? String ?? ""

        // NSSecureCoding
        food = coder.decodeObject(of: NSString.self, forKey: "name") as String? ?? ""
    }

    func encode(with coder: NSCoder) {
        coder.encode(food, forKey: "food")
    }

}
