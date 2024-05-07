//
//  yerleskeDetaylari.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/16/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class yerleskeDetaylari: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var secilmisYer = ""
    // tablo
    var yerleskeler:[Yerleskeler]? = nil
    
    @IBOutlet weak var yerleskeResmi: UIImageView!

    @IBOutlet weak var yerleskeZamanLabel: UILabel!
    @IBOutlet weak var yerleskeAdiText: UITextField!
  
    @IBOutlet weak var yerleskeTipiText: UITextField!
    @IBOutlet weak var yerleskeNotlariText: UITextView!
    
    @IBOutlet weak var yerleskeharitasi: MKMapView!
    
    var resimsecildimi:Bool=false
    
    
    
    
    
    /*
    var tarihDizisi = [String]()
    var adiDizisi = [String]()
    var tipiDizisi = [String]()
    var notlarDizisi = [String]()
    var enlemDizisi = [String]()
    var boylamDizisi = [String]()
    var resimDizisi = [String]()
 */
    var yerleskeZaman=""
    var yerleskeAdi=""
    var yerleskeTipi=""
    var yerleskeEnlem=""
    var yerleskeBoylam=""
    var yerleskeNotu = ""
    var yerleskeResim:NSData?
    
    var yerleskeid=0
    
    var manager = CLLocationManager()
    var requestCLLocation = CLLocation()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        yerleskeharitasi.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        yerleskeBul()
        
        
        yerleskeZamanLabel.text = self.yerleskeZaman
        yerleskeAdiText.text = self.yerleskeAdi
        yerleskeTipiText.text = self.yerleskeTipi
        yerleskeNotlariText.text = self.yerleskeNotu
        manager.startUpdatingLocation()
        
        
        self.yerleskeResmi.image = UIImage(data: self.yerleskeResim! as Data)
        
        // resme upluad özelliği kazandır..
        self.yerleskeResmi.isUserInteractionEnabled = true
        let gestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(self.resimSec))
        self.yerleskeResmi.addGestureRecognizer(gestureRecognizer)
        
        
        //tasarım
        
        
        self.yerleskeResmi.layer.cornerRadius = 20
        self.yerleskeResmi.layer.masksToBounds = true
        
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
        self.yerleskeResmi.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //gelen lokasyon
        
        if self.yerleskeEnlem != "" && self.yerleskeBoylam != "" {
            let location = CLLocationCoordinate2D(latitude: Double(self.yerleskeEnlem)!, longitude: Double(self.yerleskeBoylam)!)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            
            self.yerleskeharitasi.setRegion(region, animated: true)
            
            let annotation  = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = yerleskeAdi
            annotation.subtitle = yerleskeTipi
            
            self.yerleskeharitasi.addAnnotation(annotation)
        }
        
    }
    // tıklanan yeri navigasyonda gösterelim ki oraya nasıl gideriz onun yolunu görelim
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation){
            return nil
        }
        let reuseid = "pin"
        var pinView = self.yerleskeharitasi.dequeueReusableAnnotationView(withIdentifier: reuseid)
        if(pinView==nil){
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if(self.yerleskeEnlem != "" && self.yerleskeBoylam != ""){
            self.requestCLLocation = CLLocation(latitude: Double(self.yerleskeEnlem)!, longitude: Double(self.yerleskeBoylam)!)
            CLGeocoder().reverseGeocodeLocation(requestCLLocation, completionHandler: {(yermarks,erorr) in
                if let yermark = yermarks {
                    if(yermark.count > 0){
                        let mkYerMark = MKPlacemark(placemark: yermark[0])
                        let mapItem = MKMapItem(placemark: mkYerMark)
                        mapItem.name = self.yerleskeAdi
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            })
        }
    }
    
    
    
    
    func yerleskeBul(){
         yerleskeler=veritabaniIslemleri.fetcYerleskeler()
        for i in yerleskeler!{
            if(i.yerleskeAdi == secilmisYer){
                self.yerleskeZaman = i.yerleskeZamani!
                self.yerleskeAdi = i.yerleskeAdi!
                self.yerleskeTipi = i.yerleskeTipi!
                self.yerleskeEnlem = i.yerleskeEnlem!
                self.yerleskeBoylam = i.yerleskeBoylam!
                self.yerleskeNotu = i.yerleskeNotu!
                self.yerleskeResim = i.yerleskeResmi!
                
                self.yerleskeid = Int(i.yerleskeid)
                
                
            }
        }
    }
    /*
    yerleskeler=veritabaniIslemleri.fetcYerleskeler()
    if(veritabaniIslemleri.saveYerleske(yenimi: false, kullanicid: Int32(g_kullanicid), yerleskeEnlem: self.yerleskeEnlem, yerleskeBoylam: self.yerleskeBoylam, yerleskeZamani: self.yerleskeZaman, yerleskeAdi: self.yerleskeAdi, yerleskeTipi: self.yerleskeTipi, yerleskeNotu: self.yerleskeNotu, yerleskeResmi: self.yerleskeResim!)){
    self.performSegue(withIdentifier: "yerleskeDetayTOyerleskeler", sender: self)
    hizliMetodlar.MesajGoster(ekran: self, baslik: "Başarılı..", icerik: "Yerleşke başarılı bir şekilde güncellendi...")
    }
 */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func geriButtonClick(_ sender: Any) {
        self.performSegue(withIdentifier: "yerleskeDetayTOyerleskeler", sender: self)
        
    }

   
    @IBAction func kaydetButtonClick(_ sender: Any) {
        
        let yerleskeResmiYeniData: NSData = UIImageJPEGRepresentation(self.yerleskeResmi.image!, 0.5)! as NSData
        
        self.yerleskeler = veritabaniIslemleri.fetcYerleskeler()
        if(veritabaniIslemleri.saveYerleske(gelen_yerleskeid: Int32(self.yerleskeid), kullanicid: Int32(g_kullanicid), yerleskeEnlem: self.yerleskeEnlem, yerleskeBoylam: self.yerleskeBoylam , yerleskeZamani: self.yerleskeZamanLabel.text!, yerleskeAdi: self.yerleskeAdiText.text!, yerleskeTipi: self.yerleskeTipiText.text!, yerleskeNotu: self.yerleskeNotlariText.text, yerleskeResmi: yerleskeResmiYeniData)){
            
            self.performSegue(withIdentifier: "yerleskeDetayTOyerleskeler", sender: self)
        }
    }
    
    
    @IBAction func silButtonClick(_ sender: Any) {
        // veritabanında sorgu yapıp silinecek nesneyi alıyoruz
        yerleskeler = veritabaniIslemleri.yerkeskeSorgu(gelen_yerleskeid: Int32(self.yerleskeid))
        
        let alert = UIAlertController(title: "Uyarı !", message: "Bu yerleşkeyi silmek istediğinize emin misiniz ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Evet", comment: "Default action"), style: .default, handler: { _ in
            
            print("evet dendi")
            var k = -1
            
            for i in self.yerleskeler!{
                k += 1
                print(String(i.yerleskeid)+" numaralı yerleşke silindi..")
                veritabaniIslemleri.deleteYerleske(yerleskeid: (self.yerleskeler?[k])!)
                // kaydı  sildin çık
                break
            }
            self.performSegue(withIdentifier: "yerleskeDetayTOyerleskeler", sender: self)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Hayır", comment: "Default action iki"), style: .destructive, handler: { _ in
            
            print("hayır dendi")
            
            
        }))
        
        
        print("dönen:"+String(onay))
        self.present(alert, animated: true, completion: nil)
        
        
        
       
            
            // geri yönlendirme bildirimden sonra olmuyor alternatif dissmiss
           // self.dismiss(animated: true, completion: nil)
            //self.performSegue(withIdentifier: "yerleskeDetayTOyerleskeler", sender: self)
        
    }
    
    
}
