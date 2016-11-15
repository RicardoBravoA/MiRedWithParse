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

class RegisterVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Descomenta esta linea para probar que Parse funciona correctamente
        //self.testParseSave()
        
        //saveUser()
        
        //getUsers()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.current() != nil {
            self.goToMain()
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
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
        if validateData() {
            self.showActivityIndicator()
            
            let user = PFUser()
            user.username = txtEmail.text
            user.email = txtEmail.text
            user.password = txtPassword.text
            
            user.signUpInBackground(block: { (success, error) in
                
                self.stopActivityIndicator()
                
                if error != nil {
                    var errorMessage = "Ocurrió un error"
                    
                    if let message: String = error?.localizedDescription {
                        errorMessage = message
                    }
                    
                    self.showAlert(message: errorMessage)
                
                } else {
                    self.goToMain()
                    print("Usuario registrado correctamente")
                }
                
            })
            
        }
    }
    
    
    @IBAction func login(_ sender: Any) {
        if validateData() {
            
            self.showActivityIndicator()
            
            PFUser.logInWithUsername(inBackground: self.txtEmail.text!, password: self.txtPassword.text!, block: { (user, error) in
                
                self.stopActivityIndicator()
                
                if error != nil {
                    var errorMessage = "Ocurrió un error"
                    
                    if let message: String = error?.localizedDescription {
                        errorMessage = message
                    }
                    
                    self.showAlert(message: errorMessage)
                    
                } else {
                    self.goToMain()
                    print("Login realizado correctamente")
                }
                
            })
            
        }
        
    }
    
    @IBAction func recoveryPassword(_ sender: UIButton) {
        
    }
    
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func validateData() -> Bool {
        
        let email = self.txtEmail.text
        let password = self.txtPassword.text
        
        if !isValidEmail(email: email!) {
            showAlert(message: "Ingrese un email válido")
            return false
        }
        
        if !validPassword(password: password!) {
            showAlert(message: "Su contraseña debe contener al menos 6 caracteres")
            return false
        }
        
        
        return true
    }
    
    func showAlert(message:String) {
        let alertController = UIAlertController(title: "Mensaje", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func validPassword(password:String) -> Bool {
        return  password.characters.count > 5
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func isValidEmail(email:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func goToMain() {
        self.performSegue(withIdentifier: "goToMain", sender: nil)
    }

    
    
}

// hide keyboard

extension RegisterVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


