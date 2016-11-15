//
//  FriendVC.swift
//  MiRed
//
//  Created by Ricardo Bravo Acuña on 14/11/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class FriendVC: UITableViewController {

    @IBOutlet var imgMenu: UIBarButtonItem!
    var userResponse:[UserRespose] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            self.imgMenu.target = self.revealViewController()
            self.imgMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        getUsers()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userResponse.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        cell.textLabel?.text = self.userResponse[indexPath.row].name
        return cell
    }
    
    private func getUsers(){
        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.userResponse.removeAll()
                
                for object in objects! {
                    if let user = object as? PFUser {
                        
                        if user.objectId != PFUser.current()?.objectId {
                            let email = user.email
                            let name = user.username?.components(separatedBy: "@")[0]
                            let id = user.objectId
                            
                            let myUser = UserRespose(id: id!, name: name!.capitalized, email: email!)
                            self.userResponse.append(myUser)
                        }
                        
                    }
                }
                
                self.tableView.reloadData()
                
            }
        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
