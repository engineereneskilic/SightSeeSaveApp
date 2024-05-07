//
//  gelistiriciBilgileriVC.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/18/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit

class gelistiriciBilgileriVC: UIViewController {
    
    //amaç sadece geliştirici bilgilerinin gösterilmesi extra özellik eklemek istemedim.
    // Çünkü amacına uygun olmuyor o zaman...

    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let URLadres = URL(string: "https://www.kariyer.net/ozgecmis/enesskilic?o=c15o")
        
        let URListek = URLRequest(url: URLadres!)
        
        webView.loadRequest(URListek)
    
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
    
    
    @IBAction func VCkapat(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
