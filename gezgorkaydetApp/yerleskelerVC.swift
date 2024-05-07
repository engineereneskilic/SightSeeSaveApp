//
//  yerleskelerVC.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/16/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit
import CoreData


class yerleskelerVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //tablo
    var  yerleskeler:[Yerleskeler]? = nil
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var yerleskeIsimleri = [String]()
    var yerleskeResimleri = [NSData]()
    
    var onceki_id = 0;
    
    var secilenYer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //yerleskeler = veritabaniIslemleri.fetcYerleskeler()
       
        //veritabaniIslemleri.deleteYerleske(yerleskeid: (yerleskeler?[1])!)
      

       tableview.delegate = self
       tableview.dataSource = self
       tableview.backgroundView = UIImageView(image: UIImage(named: "giris.jpg"))
        
        yerleskeler = veritabaniIslemleri.fetcYerleskeler()
 
        
        //eski verileri temizle
        self.yerleskeIsimleri.removeAll(keepingCapacity: false)
       
        yerleskeler = veritabaniIslemleri.fetcYerleskeler()
        
        for i in yerleskeler!{
            // sadece ilgili kullanıcıya ait yerleşkeler gelsin..
            if(i.kullanicid == Int32(g_kullanicid)){
                if(i.yerleskeAdi != ""){
                    
                    //if(i.yerleskeid ==)
                    
                    self.yerleskeIsimleri.append(i.yerleskeAdi!)
                    self.yerleskeResimleri.append(i.yerleskeResmi!)
                    //print("Yerleske Enlem:"+i.yerleskeBoylam!)
                    
                    print("yerleşkeler: "+String(describing: i.yerleskeAdi)+"aktif kullanıcı adı "+String(i.kullanicid))
                }
            }
        }
        
        print("Aktif kullanıcı:"+String(g_kullanicid))
        /*
        for i in yerleskeler!{
            print(String(describing: i.yerleskeAdi)+" kullanicid:"+String(i.kullanicid))
        
            print("Yerkeske id"+String(i.yerleskeid))
        }
 */
        self.tableview.reloadData()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yerleskelerTOyerleskedetay" {
            let yerlesteDetay = segue.destination as! yerleskeDetaylari
            yerlesteDetay.secilmisYer = self.secilenYer
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.secilenYer = yerleskeIsimleri[indexPath.row]
        self.performSegue(withIdentifier: "yerleskelerTOyerleskedetay", sender: self)
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.yerleskeLabel.text = yerleskeIsimleri[indexPath.row]
        cell.yerleskeResmi.image = UIImage(data: yerleskeResimleri[indexPath.row] as Data)
        
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.yerleskeResmi.image = UIImage(data: yerleskeResimleri[indexPath.row] as Data)
        cell.yerleskeResmi.layer.masksToBounds = true
        cell.yerleskeResmi.layer.cornerRadius = cell.yerleskeResmi.frame.height / 2
        cell.yerleskeResmi.layer.borderWidth = 2
        cell.yerleskeResmi.layer.borderColor = UIColor.white.cgColor
        cell.yerleskeResmi.contentMode = .scaleAspectFill
        cell.cellView.layer.borderWidth = 2
        cell.cellView.layer.borderColor = UIColor.white.cgColor
        cell.yerleskeLabel.font = UIFont.boldSystemFont(ofSize: 25)
        cell.yerleskeLabel.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.0)
    
        
        
        /*
        cell.contentView.backgroundColor = UIColor(red: 0.24, green: 0.51, blue: 0.93, alpha: 1.0)
        
        cell.textLabel?.text = yerleskeIsimleri[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.imageView?.image = UIImage(data: yerleskeResimleri[indexPath.row] as Data)
        
        cell.imageView?.layer.masksToBounds = true
     
        
        cell.imageView?.frame = UIEdgeInsetsInsetRect(tableView.frame, UIEdgeInsetsMake(0, 16, 0, 16))
        cell.imageView?.layer.cornerRadius = 20
        
        cell.imageView?.layoutMargins.bottom = 30
        

        
        cell.imageView?.contentMode = .scaleAspectFit
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.layer.borderWidth = 2
        cell.layer.borderColor =  UIColor.white.cgColor
        cell.layoutMargins.top = 15
        cell.layoutMargins.bottom = 15
        
        cell.contentView.layer.masksToBounds = true
        
        cell.contentView.layoutMargins.bottom = 70
        */
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yerleskeIsimleri.count
    }
   
    
    @IBAction func oturumuKapatClick(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "girisyapildimi")
        UserDefaults.standard.synchronize()
        
        let girisVC = self.storyboard?.instantiateViewController(withIdentifier: "girisVC") as! girisVC
        
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.window?.rootViewController = girisVC
        delegate.benihatirla()
    }

    @IBAction func yerleskeEkleClick(_ sender: Any) {
        
        self.performSegue(withIdentifier: "yerTOyerEkle", sender: nil)
        
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
