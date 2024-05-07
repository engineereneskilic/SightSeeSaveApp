//
//  tasarimlar.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/16/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit

class tasarimlar: NSObject {
    
    class func buttonTasarimi(gelenbutton: UIButton){
        gelenbutton.backgroundColor = UIColor(red: 0.1961, green: 0.6314, blue: 1, alpha: 1.0)
        gelenbutton.layer.cornerRadius = gelenbutton.frame.height / 2
        gelenbutton.setTitleColor(UIColor.white, for: .normal)
        
        gelenbutton.layer.shadowRadius = 6
    }
}
