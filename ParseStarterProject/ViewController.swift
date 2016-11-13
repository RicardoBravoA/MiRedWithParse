/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Descomenta esta linea para probar que Parse funciona correctamente
        //self.testParseSave()
        
        saveUser()
        
        getUsers()
        
    }
    
    func saveUser(){
        let user = PFObject(className: "Usuario")
        user["name"] = "Ricardo"
        user.saveInBackground { (success, error) -> Void in
            if success {
                print("Registro Insertado")
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func getUsers(){
        let query = PFQuery(className: "Usuario")
        query.getObjectInBackground(withId: "qzDrjZv0ju") { (object, error) -> Void in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let user = object {
                    print(user)
                    print("Usuario: \(user["name"]!)")
                }
            }
        }
        
    }
    
    @IBAction func register(_ sender: UIButton) {
    }
    
    
    @IBAction func login(_ sender: Any) {
    }
    
    @IBAction func recoveryPassword(_ sender: UIButton) {
    }
    
    /*
    func testParseSave() {
        let testObject = PFObject(className: "MyTestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackground { (success, error) -> Void in
            if success {
                print("El objeto se ha guardado en Parse correctamente.")
            } else {
                if error != nil {
                    print (error)
                } else {
                    print ("Error")
                }
            }
        }
    }
     */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// hide keyboard

extension ViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


