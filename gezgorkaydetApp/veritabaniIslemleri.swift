//
//  veritabaniIslemleri.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/16/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit
import CoreData

class veritabaniIslemleri: NSObject {
    
    
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    
    // kaydet grubu
    class func saveKullanici(kullaniciadi:String, sifre:String, adi:String, email:String, kulaniciResim:NSData, sifretekrar:String, soyadi:String) -> Bool{
        let context = getContext()
        let entitiy = NSEntityDescription.entity(forEntityName: "Kullanicilar", in: context)
        let manageObject = NSManagedObject(entity: entitiy!, insertInto: context)
        
        manageObject.setValue(kullaniciadi, forKey: "kullaniciadi")
        manageObject.setValue(sifre, forKey: "sifre")
        manageObject.setValue(adi, forKey: "adi")
        manageObject.setValue(email, forKey: "email")
        manageObject.setValue(kulaniciResim, forKey: "kullaniciResim")
        manageObject.setValue(sifretekrar, forKey: "sifretekrar")
        manageObject.setValue(soyadi, forKey: "soyadi")
        
        var kullanicilar:[Kullanicilar]? = nil
        
        
        kullanicilar = veritabaniIslemleri.fetcKullanicilar()
        var id = 0
        
        for i in kullanicilar!{
           id = Int(i.id)
        }
        id+=3
        manageObject.setValue(id, forKey: "id")
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
        
    }
    
    class func saveYerleske(gelen_yerleskeid:Int32, kullanicid:Int32, yerleskeEnlem:String, yerleskeBoylam:String ,yerleskeZamani:String ,yerleskeAdi:String, yerleskeTipi:String, yerleskeNotu:String,yerleskeResmi:NSData) -> Bool{
        
        var yerleskeler:[Yerleskeler]? = nil
        yerleskeler = fetcYerleskeler()
        if(gelen_yerleskeid != 0){
         for i in yerleskeler!{
            if(gelen_yerleskeid == i.yerleskeid){
            yerleskeler =  yerkeskeSorgu(gelen_yerleskeid: i.yerleskeid)
                
                var k = -1
                
                for i in yerleskeler!{
                    k += 1
                    print("save yerleske id"+String(i.yerleskeid))
                    deleteYerleske(yerleskeid: (yerleskeler?[k])!)
                }
                break
            }
            }
        }
        
        
        let context = getContext()
        let entitiy = NSEntityDescription.entity(forEntityName: "Yerleskeler", in: context)
        let manageObject = NSManagedObject(entity: entitiy!, insertInto: context)
        
        
        manageObject.setValue(kullanicid, forKey: "kullanicid")
        manageObject.setValue(yerleskeEnlem, forKey: "yerleskeEnlem")
        manageObject.setValue(yerleskeBoylam, forKey: "yerleskeBoylam")
        manageObject.setValue(yerleskeZamani, forKey: "yerleskeZamani")
        manageObject.setValue(yerleskeAdi, forKey: "yerleskeAdi")
        manageObject.setValue(yerleskeTipi, forKey: "yerleskeTipi")
        manageObject.setValue(yerleskeNotu, forKey: "yerleskeNotu")
        manageObject.setValue(yerleskeResmi, forKey: "yerleskeResmi")
        
    
        
        var yerleskeid = gelen_yerleskeid
        
        yerleskeler = veritabaniIslemleri.fetcYerleskeler()

        if(yerleskeid == 0){ // yeni veriyse bir alt satıra geç(yeni ekle)
            for i in yerleskeler!{
                yerleskeid = Int32(i.yerleskeid)
            }
            yerleskeid+=1
        }
        manageObject.setValue(yerleskeid, forKey: "yerleskeid")
        do{
            try context.save()
            return true
        }catch{
            return false
        }
        
        
    }
    class func saveLogKullanici(kulllaniciadi:String, kullanicid:Int32) -> Bool{
        
        
        
        
        
        
        let context = getContext()
        let entitiy = NSEntityDescription.entity(forEntityName: "LogKullanici", in: context)
        let manageObject = NSManagedObject(entity: entitiy!, insertInto: context)
        
        manageObject.setValue(kulllaniciadi, forKey: "kullaniciadi")
        manageObject.setValue(kullanicid, forKey: "kullanicid")
        
        var logkullanicilar:[LogKullanici]? = nil
        
        
        logkullanicilar = veritabaniIslemleri.fetclogKullanici()
        var logid = 0
        
        for i in logkullanicilar!{
            logid = Int(i.logid)
        }
        logid+=1

        manageObject.setValue(logid, forKey: "logid")
        
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
    
    

    // listeyi al grubu
    class func fetcKullanicilar() -> [Kullanicilar]? {
        let context = getContext()
        var kullanicilar:[Kullanicilar]? = nil
        do{
            kullanicilar = try context.fetch(Kullanicilar.fetchRequest())
            return kullanicilar
        } catch{
            return kullanicilar
        }
    }
    class func fetcYerleskeler() -> [Yerleskeler]? {
        let context = getContext()
        var yerleskeler:[Yerleskeler]? = nil
        do{
            yerleskeler = try context.fetch(Yerleskeler.fetchRequest())
            return yerleskeler
        } catch{
            return yerleskeler
        }
    }
    class func fetclogKullanici() -> [LogKullanici]? {
        let context = getContext()
        var logKullanicilar:[LogKullanici]? = nil
        do{
            logKullanicilar = try context.fetch(LogKullanici.fetchRequest())
            return logKullanicilar
        } catch{
            return logKullanicilar
        }
    }
    // silme grubu
    class func deleteYerleske(yerleskeid:Yerleskeler){
        let context = getContext()
        context.delete(yerleskeid)
        do{
            try context.save()
            
        }catch{
            
        }
    }
    
    class func yerkeskeSorgu(gelen_yerleskeid:Int32) -> [Yerleskeler]?{
        let context = getContext()
        let fetchRequest:NSFetchRequest<Yerleskeler> = Yerleskeler.fetchRequest()
        var yerleske:[Yerleskeler]? = nil
        
        let pradicate = NSPredicate(format: "yerleskeid contains[c] %@", String(gelen_yerleskeid))
        fetchRequest.predicate = pradicate
        do{
            yerleske = try context.fetch(fetchRequest)
            return yerleske
            
        }catch{
            return yerleske
        }
    
    }

}

