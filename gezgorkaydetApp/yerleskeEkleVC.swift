//
//  yerleskeEkleVC.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/16/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit


//her yerde kullanacağım degişkenkerim..


    var g_yerleskeZamani = ""
    var g_yerleskeAdi = ""
    var g_yerleskeTipi = ""
    var g_yerleskeNotlari = ""
    var g_yerleskeResmi = UIImage()

 class yerleskeEkleVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var yerleskeZamaniText: UITextField!
    
    @IBOutlet weak var yerleskeAdiText: UITextField!
    
    @IBOutlet weak var yerleskeTipiText: UITextField!
    
   
    @IBOutlet weak var yerleskeNotlariText: UITextView!
    
    @IBOutlet weak var yerleskeResmi: UIImageView!
    
    var resimsecildimi:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resimsecildimi=false
        // resme upluad özelliği kazandır..
        yerleskeResmi.isUserInteractionEnabled = true
        let gestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(yerleskeEkleVC.resimSec))
        yerleskeResmi.addGestureRecognizer(gestureRecognizer)
        
        yerleskeZamaniText.text=gecerliZaman()
        yerleskeNotlariText.text = ""
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    
        
        // sürekli temiz tut
        
        g_yerleskeZamani = ""
        g_yerleskeAdi = ""
        g_yerleskeTipi = ""
        g_yerleskeNotlari = ""
        g_yerleskeResmi = UIImage()
        /*
        yerleskeAdiText.text = ""
        yerleskeTipiText.text = ""
        yerleskeNotlariText.text = ""
 */
    }
    func gecerliZaman() -> String{
        let formatter = DateFormatter()
        //formatter.dateStyle = .long
        //formatter.timeStyle = .medium
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        let str = formatter.string(from: Date())
        return str;
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

  
    @IBAction func ileriClick(_ sender: Any) {
        
        
        
        // doldur verileri devam et
        if(!hizliMetodlar.TextBosMu(gelen: yerleskeZamaniText) && !hizliMetodlar.TextBosMu(gelen: yerleskeAdiText) && !hizliMetodlar.TextBosMu(gelen: yerleskeTipiText) && yerleskeNotlariText.text != "" ){
            if let secilenResim =  yerleskeResmi.image{
            
                g_yerleskeZamani = yerleskeZamaniText.text!
                g_yerleskeAdi = yerleskeAdiText.text!
                g_yerleskeTipi = yerleskeTipiText.text!
                g_yerleskeNotlari = yerleskeNotlariText.text!
                g_yerleskeResmi = secilenResim
                
                
            }
            if (resimsecildimi) {
                self.performSegue(withIdentifier: "yerleskeEkleTOyerleskeSec", sender: self)
            }else{
                hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata!", icerik: "Lütfen yerleşkenizi temsil eden resmi seçiniz !")
            }
            
        }else if(hizliMetodlar.TextBosMu(gelen: yerleskeAdiText)){
                hangisiBos(bos_olan: "Yerleşke Adını")
        }else if(hizliMetodlar.TextBosMu(gelen: yerleskeTipiText)){
                hangisiBos(bos_olan: "Yerleşke Tipini")
        }else if(yerleskeNotlariText.text == ""){
                hangisiBos(bos_olan: "Yerleske Notlarını")
        }
        // kullanıcı isterse resimde eklemeyebilir..
        
        
 
        
        
        
        //  gönderdik geçmişi temizle
        /*
        yerleskeZamaniText.text=gecerliZaman()
        yerleskeAdiText.text=""
        yerleskeTipiText.text=""
        yerleskeNotlariText.text=""
        yerleskeResmi.image = UIImage(named: "upluad-icon.jpg")
 
*/
        
        
    }
    
    
    @objc func resimSec(){
        resimsecildimi=true
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        yerleskeResmi.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func hangisiBos(bos_olan:String){
        hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata !", icerik: "Lütfen "+bos_olan+" boş bırakmayınız !")
    }
    
    
    @IBAction func geriMenuBarItemClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
