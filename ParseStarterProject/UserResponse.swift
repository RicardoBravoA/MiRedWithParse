//
//  User.swift
//  MiRed
//
//  Created by UNT Ricardo Bravo on 15/11/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class UserRespose: NSObject {
    
    var id: String!
    var name: String!
    var email: String!
    
    init(id:String, name:String, email:String) {
        self.id = id
        self.name = name
        self.email = email
    }
    

}
