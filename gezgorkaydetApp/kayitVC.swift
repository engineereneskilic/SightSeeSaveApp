//
//  kayitVC.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/18/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit

class kayitVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var kullanicilar:[Kullanicilar]? = nil
    
    @IBOutlet weak var kullaniciResim: UIImageView!
    @IBOutlet weak var kullaniciAdiText: UITextField!
    @IBOutlet weak var kullaniciSoyadiText: UITextField!
    @IBOutlet weak var kullaniciEmailText: UITextField!
    @IBOutlet weak var kullanici_kAdiText: UITextField!
    @IBOutlet weak var kullaniciSifreText: UITextField!
    @IBOutlet weak var kullaniciSifreTekrar: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // resme upluad özelliği kazandır..
        kullaniciResim.isUserInteractionEnabled = true
        let gestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(yerleskeEkleVC.resimSec))
        kullaniciResim.addGestureRecognizer(gestureRecognizer)
        
    kullaniciSifreText.isSecureTextEntry=true
    kullaniciSifreTekrar.isSecureTextEntry=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var varmi: Bool = false;
    
    var yuklenenResim = UIImage()
    
    var formathatasi: Bool = false;
    @IBAction func kaydet(_ sender: Any) {
        if let secilenResim =  self.kullaniciResim.image{
            yuklenenResim = secilenResim
        }
        let kullaniciResim_data: NSData = UIImageJPEGRepresentation(yuklenenResim, 0.5)! as NSData
        
        if !hizliMetodlar.TextBosMu(gelen: self.kullaniciAdiText) && !hizliMetodlar.TextBosMu(gelen: self.kullaniciSoyadiText) && !hizliMetodlar.TextBosMu(gelen: self.kullaniciEmailText) && !hizliMetodlar.TextBosMu(gelen: self.kullanici_kAdiText) && !hizliMetodlar.TextBosMu(gelen: self.kullaniciSifreText) && !hizliMetodlar.TextBosMu(gelen: self.kullaniciSifreTekrar) && String(describing: kullaniciResim_data) != "" {
            
            if(!hizliMetodlar.emailKontrol(kullaniciEmailText.text!)){
               
                formathatasi=true
                 hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata !", icerik: "Email adresinizi doğru formatta giriniz !")
            }
            if(self.kullaniciSifreText.text != self.kullaniciSifreTekrar.text){
                formathatasi=true
                hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata !", icerik: "Lütfen şifrenizi aynı giriniz !")
            }
            
            kullanicilar = veritabaniIslemleri.fetcKullanicilar()
            
            for i in kullanicilar!{
                
                if(i.kullaniciadi! == kullanici_kAdiText.text){
                    self.varmi=true;
                    print("buldum kayıtlısın sen")
                    break;
                }
            }
            
            if(!self.varmi && !self.formathatasi){
                if veritabaniIslemleri.saveKullanici(kullaniciadi: self.kullanici_kAdiText.text!, sifre: self.kullaniciSifreText.text!, adi: self.kullaniciAdiText.text!, email: self.kullaniciEmailText.text!, kulaniciResim: kullaniciResim_data, sifretekrar: self.kullaniciSifreTekrar.text!, soyadi: self.kullaniciSoyadiText.text!){
                    kullanicilar = veritabaniIslemleri.fetcKullanicilar()
                    hizliMetodlar.MesajGoster(ekran: self, baslik: "Başarılı..", icerik: "Kayıt Başarılı")
                    
                    // yeni kullanıcıyı karşılayalım..
                    hizliMetodlar.MesajGoster(ekran: self, baslik: "Hoşgeldiniz..", icerik: "Merhaba "+self.kullaniciAdiText.text!+" "+kullaniciSoyadiText.text!+" Hoşgeldiniz.."
                    )
                    
                    
                    // beni hatırla
                    UserDefaults.standard.set(self.kullaniciAdiText.text, forKey: "girisyapildimi")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.benihatirla()
                    
                }else{
                    hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata !", icerik: "Kaydederken bir hata oluştu !")
                }
            } else{
                hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata !", icerik: "Zaten Kayıtlısınız..")
            }
            
        }else{
            hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata !",icerik: "Lütfen tüm alanları doldurunuz !");
            
        }
    }
    
    @IBAction func kapatClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @objc func resimSec(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.kullaniciResim.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
