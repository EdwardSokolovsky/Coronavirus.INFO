//
//  ViewController.swift
//  Coronavirus.INFO
//
//  Created by Edward on 15.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func doBtnStart(_ sender: Any) {
        
        self.showSpinner()
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (t) in
            print("done")
//            self.removeSpinner()
        }
    }
    
}
