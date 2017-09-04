//
//  ViewController.swift
//  Calculator
//
//  Created by kevin on 03/09/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit
import AVFoundation
class CalculatorVC: UIViewController {

    @IBOutlet weak var CounterLblOL: UILabel!
    var btnsound: AVAudioPlayer!
    var OpratorState = Oprator.Empty
    var OPNumber = ""
    var Leftval = ""
    var Rightval = ""
    var result = ""
    enum Oprator: String {
        case Divide = "/"
        case Multiply = "*"
        case adding = "+"
        case subtracting = "-"
        case Empty = "Empty"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav") // creating path value
        let soundURL = URL(fileURLWithPath: path!) //declare URL with path
     
        do {
            try btnsound = AVAudioPlayer(contentsOf: soundURL)
            btnsound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    
    CounterLblOL.text = "0"
    }
    
    
    
    
    @IBAction func onAddPressed(sender: AnyObject) {
        Calculation(oprator: .adding )
        Soundplaying()
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        Calculation(oprator: .subtracting )
        Soundplaying()
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        Calculation(oprator: .Multiply )
        Soundplaying()
    }
    @IBAction func onDividePressed(sender: AnyObject) {
        Calculation(oprator: .Divide )
        Soundplaying()
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        Calculation(oprator: OpratorState )
        Soundplaying()
        }
    @IBAction func onClearing(sender:AnyObject) {
        Soundplaying()
        CounterLblOL.text = "0"
        OpratorState = Oprator.Empty
        OPNumber = ""
        Leftval = OPNumber
        Rightval = OPNumber
        
    }
    

    @IBAction func BtnPressed(sender : UIButton){
        Soundplaying()
        OPNumber += "\(sender.tag)"
        CounterLblOL.text = OPNumber
    }
    func Soundplaying() {
        if btnsound.isPlaying {
            btnsound.stop()
        }
    btnsound.play()
    }
    func Calculation(oprator : Oprator){
        if OpratorState != Oprator.Empty {
            if OPNumber != "" {
                Rightval = OPNumber
                OPNumber = ""
                
                if OpratorState == Oprator.Multiply {
                    result = "\(Double(Leftval)! * Double(Rightval)!)"
                } else if OpratorState == Oprator.adding {
                    result = "\(Double(Leftval)! + Double(Rightval)!)"
                } else if OpratorState == Oprator.subtracting {
                    result = "\(Double(Leftval)! - Double(Rightval)!)"
                } else if OpratorState == Oprator.Divide {
                    result = "\(Double(Leftval)! / Double(Rightval)!)"
            }
                Leftval = result
                CounterLblOL.text = result
            }
                OpratorState = oprator
        } /* big if  ends */else {
            Leftval = OPNumber
            OPNumber = ""
            OpratorState = oprator
            
        }
        
        
    }

}

