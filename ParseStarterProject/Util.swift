//
//  Util.swift
//  MiRed
//
//  Created by Ricardo Bravo Acuña on 13/11/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation

class Util {
    
}

extension String {
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}
