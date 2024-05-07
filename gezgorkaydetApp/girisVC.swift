//
//  girisVC.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/16/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit
import CoreData

var g_kullanicid = 0;

class girisVC: UIViewController {
    
    //tablo
     var kullanicilar:[Kullanicilar]? = nil
    var logkullanici:[LogKullanici]? = nil
    
    @IBOutlet weak var kaydetButton: UIButton!
    @IBOutlet weak var girisButton: UIButton!
    
    @IBOutlet weak var kullaniciAdiText: UITextField!
    @IBOutlet weak var sifreText: UITextField!
    
    @IBOutlet weak var kullaniciResmi: UIImageView!
    
    
    var kullaniciResim:NSData?
    var sayac:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hizliMetodlar.buttonTasarimi(gelenbutton: kaydetButton)
        hizliMetodlar.buttonTasarimi(gelenbutton: girisButton)
        
        hizliMetodlar.TextFieldIconEkle(textfield: self.kullaniciAdiText, andImage: UIImage(named: "user-icon.png")!)
        hizliMetodlar.TextFieldIconEkle(textfield: self.sifreText, andImage: UIImage(named: "password-icon.png")!)
        
        // son kullanıcı
        
        kullanicilar = veritabaniIslemleri.fetcKullanicilar()
        var sonkullaniciid:Int32 = 0;
        // son kullanıcı idsini al
        logkullanici = veritabaniIslemleri.fetclogKullanici()
        for  k in logkullanici!{
                sonkullaniciid = k.kullanicid
        }
        // kullanıcılardan bul getir.
        sayac=0
        for i in kullanicilar!{
            if(sonkullaniciid == i.id){
                sayac += 1
                if(sayac == 2 && i.id == 1 || i.id != 1){
                    if(sayac == 2 && i.id == 3 || i.id != 3){
                        self.kullaniciAdiText.text=i.kullaniciadi
                        self.sifreText.text = i.sifre
                        self.kullaniciResim = i.kullaniciResim
                        
                        break
                    }
                }
            }
        }
        sayac = 0
        g_kullanicid=Int(sonkullaniciid)
        self.kullaniciResmi.image = UIImage(data: self.kullaniciResim! as Data)
        
        sifreText.isSecureTextEntry = true
        
        // listele
       /*
        for i in kullanicilar!{
            print(String(i.id)+" adı:"+String(describing: i.kullaniciadi))
        }
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var bulundu: Bool = false;
    
    @IBAction func kaydolClick(_ sender: Any) {
        
        
    }
    
    
    @IBAction func girisClick(_ sender: Any) {
        kullanicilar = veritabaniIslemleri.fetcKullanicilar()
        
        for i in kullanicilar!{
            
            if(i.kullaniciadi! == self.kullaniciAdiText.text && self.sifreText.text == i.sifre){
                bulundu=true
                
                // kullanıcı oturumunu açmıştır log kaydı tutalım..
                logkullanici = veritabaniIslemleri.fetclogKullanici()
                if(veritabaniIslemleri.saveLogKullanici(kulllaniciadi: self.kullaniciAdiText.text!, kullanicid:i.id)){
                    print("kaydedilen log kullanıcı id:"+String(i.id))
                    //kullanıcıyı karşılayalım
                    hizliMetodlar.MesajGoster(ekran: self, baslik: "Hoşgeldiniz..", icerik: "Merhaba "+i.adi!+" "+i.soyadi!+" Hoşgeldiniz..")
                
                g_kullanicid = Int(i.id)
                
                // beni hatırla
                UserDefaults.standard.set(String(g_kullanicid), forKey: "girisyapildimi")
                UserDefaults.standard.synchronize()
                
                let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                delegate.benihatirla()
                }

            }
        }
        
        if(!bulundu){
            hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata !", icerik: "Kullanıcı adı veya şifre yanlış !")
        }
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
