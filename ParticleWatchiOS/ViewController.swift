//
//  ViewController.swift
//  Test2_PArticle
//
//  Created by Z Angrazy Jatt on 2019-11-05.
//  Copyright © 2019 Parrot. All rights reserved.
//test-2-mad5314.ino : Added on GitHub
//smlieFaceLight_test-2-mad5314.ino added

import UIKit
import Particle_SDK
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate{
        func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {

                }
    }
   

    // MARK: User variables
    let USERNAME = "eramriksidhu@gmail.com"
    let PASSWORD = "gill@000"
    
    // MARK: Device
    let DEVICE_ID = "2b0040000f47363333343437"
    var myPhoton : ParticleDevice?
    
    // partcle varibles
    var timeElapseSendToParticle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            // 1. Check if phone supports WCSessions
            print("Phone view loaded")
            if WCSession.isSupported() {
                print("Phone supports WCSession")
                WCSession.default.delegate = self
                WCSession.default.activate()
                print("Session Activated")
            }
            else {
                print("Phone does not support WCSession")
            }
        }
        
        // 1. Initialize the SDK
        ParticleCloud.init()
 
        // 2. Login to your account
        ParticleCloud.sharedInstance().login(withUser: self.USERNAME, password: self.PASSWORD) { (error:Error?) -> Void in
            if (error != nil) {
                // Something went wrong!
                print("Wrong credentials or as! ParticleCompletionBlock no internet connectivity, please try again")
                // Print out more detailed information
                print(error?.localizedDescription)
            }
            else {
                print("Login success!")
            }
        } // end login
        
        self.getDeviceFromCloud()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Get Device from Cloud
    // Gets the device from the Particle Cloud
    // and sets the global device variable
    func getDeviceFromCloud() {
    ParticleCloud.sharedInstance().getDevice(self.DEVICE_ID) { (device:ParticleDevice?, error:Error?) in
            
            if (error != nil) {
                print("Could not get device")
                print(error?.localizedDescription)
                return
            }
            else {
                print("Got photon: \(device?.id)")
                self.myPhoton = device
            }
            
        }
    }
    
    @IBOutlet weak var lblTimeElapsed: UILabel!
    
    @IBAction func btnStartMonitoringClicked(_ sender: Any) {
        
        print("sending Clicked")
        self.timeOnphone()
        
        
            }
    
    public func timeOnphone()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.timeElapseSendToParticle = self.timeElapseSendToParticle + 1
                    self.lblTimeElapsed.text = "\(self.timeElapseSendToParticle)"
                    self.timeOnphone()
        
                }
    }

    }
    
   
    
    
    
  

   
    
    
    



