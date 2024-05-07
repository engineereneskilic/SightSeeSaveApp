//
//  yerleskeSecVC.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/16/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class yerleskeSecVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate, UISearchBarDelegate {

    var yerleskeler:[Yerleskeler]? = nil
    
    @IBOutlet weak var haritaView: MKMapView!
   
    @IBOutlet weak var yerAraTabbarButton: UIBarButtonItem!
    
    
    var manager = CLLocationManager()
    
    //seçilen konum
    var chosenLatitude = ""
    var chosenLongitude = ""
    
    //anlık konum bilgileri
    var location = ""
    let span = "";
    let region = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        haritaView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(yerleskeSecVC.yerSec(gestureRecognizer:)))
        
        recognizer.minimumPressDuration = 3 // 3 saniye basılı tutunca
        haritaView.addGestureRecognizer(recognizer)
    
        
        
    }
    
    var odakla:Int = 0;
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        odakla += 1
        // Sürekli bulunduğum yeri odaklamasını istemem çünkü haritadan sınırlı sayıda yer seçebiliyorum. Bir kere beni bulsun yeterli..
        if(odakla == 1){
       let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
       let  span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
       let  region = MKCoordinateRegion(center: location, span: span)
        
        haritaView.setRegion(region, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var resimkodu="";
    let g_yerleskeResmi_data: NSData = UIImageJPEGRepresentation(g_yerleskeResmi, 0.5)! as NSData
    @IBAction func kaydetClick(_ sender: Any) {
        
         yerleskeler = veritabaniIslemleri.fetcYerleskeler();
    
       
        
        if(veritabaniIslemleri.saveYerleske(gelen_yerleskeid: 0, kullanicid: Int32(g_kullanicid), yerleskeEnlem: self.chosenLatitude, yerleskeBoylam: chosenLongitude, yerleskeZamani: g_yerleskeZamani, yerleskeAdi: g_yerleskeAdi, yerleskeTipi: g_yerleskeTipi, yerleskeNotu: g_yerleskeNotlari, yerleskeResmi: g_yerleskeResmi_data)){
            
           
            
            self.performSegue(withIdentifier: "yerleskeSecTOyerleskeler", sender: self)
            
        }else{
            hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata !", icerik: "Yerleşke Kaydedilemedi !")
        }

        
        
    }
  
    @IBAction func iptalClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func yerAraTabbarButtonClick(_ sender: Any) {
        let yerAraController = UISearchController(searchResultsController: nil)
        yerAraController.searchBar.delegate = self
        present(yerAraController,animated: true, completion: nil)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //vazgeçme
        UIApplication.shared.beginIgnoringInteractionEvents()
        ///seçilen aktif olan yer
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //bar gizlendiğinde
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Arama yapılıp istek geldiğinde
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if(response == nil){
                hizliMetodlar.MesajGoster(ekran: self, baslik: "Hata !", icerik: "Aranılan Yer Bulunurken Bir Hata ile Karşılaşıldı !")
            }
            else
            {
                    //tüm seçilmiş konumları(iğneler) sil
                let annotations = self.haritaView.annotations
                self.haritaView.removeAnnotations(annotations)
                
                    //İstenen veriyi getir..
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                // İstenilen konumu yarat
                let annnotation = MKPointAnnotation()
                annnotation.title = searchBar.text
                annnotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                
                self.haritaView.addAnnotation(annnotation)
                
                // konumu yakınlaştır
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                
                self.haritaView.setRegion(region, animated: true)
                
            }
        }
    }
    
    
    @objc func yerSec(gestureRecognizer: UIGestureRecognizer){
       
        if(gestureRecognizer.state == UIGestureRecognizerState.began){
            
            //tüm seçilmiş konumları(iğneler) sil
            let annotations = self.haritaView.annotations
            self.haritaView.removeAnnotations(annotations)
            
            //el ile seçilen konum
            let dokunuldu = gestureRecognizer.location(in: self.haritaView)
            let koordinatlar = self.haritaView.convert(dokunuldu, toCoordinateFrom: self.haritaView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = koordinatlar
            annotation.title = g_yerleskeAdi
            annotation.subtitle = g_yerleskeTipi
            
            self.haritaView.addAnnotation(annotation)
            
            // seçilen koordinat aktarması
            self.chosenLatitude = String(koordinatlar.latitude)
            self.chosenLongitude = String(koordinatlar.longitude)
           
        }
    }
    

    
    
    
    // her view açıldığında çalışacak methot
    override func viewWillAppear(_ animated: Bool) {
        self.chosenLongitude = ""
        self.chosenLatitude = ""
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
