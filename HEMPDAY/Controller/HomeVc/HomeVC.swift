//
//  HomeVC.swift
//  HEMPDAY
//
//  Created by admin on 12/11/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var menuView : UIView!
    @IBOutlet weak var TableVW : UITableView!
    
     @IBOutlet weak var userNameLbl : UILabel!
    
    let menuArray = ["HEMP MATCHES","DISPENSARIES","HEMP MATES","MY HEMPDAY","SHARE"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLbl.text = "\(UserDefaults.standard.value(forKey: "UserName") as! String)!"
        TableVW.delegate = self
        TableVW.dataSource = self
        if UserDefaults.standard.value(forKey: "viewResult") as? Bool == true{
            let vc = storyboard?.instantiateViewController(identifier: "ShawProductResultVC") as! ShawProductResultVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
               self.navigationController?.isNavigationBarHidden = true
           }
           
    override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = true
        }
    
    @IBAction func menuButtonAction( _ sender : UIButton){
        
        self.menuView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(self.menuView)
        
    }
    
    @IBAction func crossButtonAction( _ sender : UIButton){
        self.menuView.removeFromSuperview()
       }
    @IBAction func myProfileButtonAction( _ sender : UIButton){
        
      let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func hempMatchesButtonAction( _ sender : UIButton){
         let vc = storyboard?.instantiateViewController(identifier: "PreviousMatchesVC") as! PreviousMatchesVC
               self.navigationController?.pushViewController(vc, animated: true)
       }
    @IBAction func dispensariesButtonAction( _ sender : UIButton){
        
        let vc = storyboard?.instantiateViewController(identifier: "DispensariesMapVC") as! DispensariesMapVC
        self.navigationController?.pushViewController(vc, animated: true)
           
       }
    @IBAction func hempMatesButtonAction( _ sender : UIButton){
           let vc = storyboard?.instantiateViewController(identifier: "DispensariesVC") as! DispensariesVC
           self.navigationController?.pushViewController(vc, animated: true)
       }
    @IBAction func myHempdayButtonAction( _ sender : UIButton){
           let vc = storyboard?.instantiateViewController(identifier: "MyHempDayVC") as! MyHempDayVC
           self.navigationController?.pushViewController(vc, animated: true)
       }
    @IBAction func shareButtonAction( _ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "ShareVC") as! ShareVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func logoutButtonAction( _ sender : UIButton){
        logoutAlert()
    }
    
    func logoutAlert() {
        let alertController = UIAlertController(title: "HEMPDAY", message: "ARE YOU SURE TO LOGOUT?", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            //MARK:- User Default Set Value null....
            UserDefaults.standard.set(nil, forKey: "UserId")
            UserDefaults.standard.set("No", forKey: "isLogin")
            UserDefaults.standard.set(nil, forKey: "UserName")
          
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let VC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        alertController.setBackgroundColor(color: UIColor(named: "Color4")!)
        alertController.setTitlet(font: UIFont(name: "Bristol", size: 25.00), color: UIColor(named: "Color1"))
        alertController.setMessage(font: UIFont(name: "Bristol", size: 16.00), color: UIColor(named: "Color1"))
        okAction.setValue(UIColor(named: "Color1"), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(named: "Color1"), forKey: "titleTextColor")
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}

extension HomeVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableVW.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        cell.lbl.text = menuArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:  tableView.bounds.size.height))
        headerView.backgroundColor = UIColor(named: "Color4")
      
      return headerView
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 0{
            
            let vc = storyboard?.instantiateViewController(identifier: "PreviousMatchesVC") as! PreviousMatchesVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1{
            let vc = storyboard?.instantiateViewController(identifier: "DispensariesMapVC") as! DispensariesMapVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            let vc = storyboard?.instantiateViewController(identifier: "DispensariesVC") as! DispensariesVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            let vc = storyboard?.instantiateViewController(identifier: "MyHempDayVC") as! MyHempDayVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4{
            let vc = storyboard?.instantiateViewController(identifier: "ShareVC") as! ShareVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var size = CGFloat()
        if view.frame.size.height > 812{
            size = 105.00
        }else{
            size = 90.00
        }
        return size
    }
}
