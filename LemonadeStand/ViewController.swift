//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Hurewitz, Matthew on 8/3/15.
//  Copyright (c) 2015 Hurewitz, Matthew. All rights reserved.
//

import UIKit
//import swirl_sdk


class ViewController: UIViewController {
    
    var cashOnHand = 10
    var lemonInventory = 1
    var iceCubeInventory = 1
    
    var lemonInventorySubTotal = 0
    var iceCubeInventorySubTotal = 0
    
    var lemonMixSubTotal = 0
    var iceMixSubTotal = 0
    
    var lemonadeRatio = 0.0
    
    
    //Swirl Test
    
    let APP_KEY = "sEsOsRlePuBj0tgGynzRJp1B6hnwKYAFBwv6TtA7mlw5B"
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject:
        AnyObject]?) -> Bool {
            // specify a delegate if you want optional callbacks
            Swirl.shared().startWithDelegate(nil, key: APP_KEY, options:
                nil);
            
            if application.applicationState !=
                UIApplicationState.Background {
                    self.viewDidLoad()
            }
            
            return true
    }
    
    func application(application: UIApplication,
        didReceiveLocalNotification notification: UILocalNotification) {
            if !Swirl.shared().showContentForNotification(notification) {
                // Handle non-Swirl local notifications here
            }
    }
    
    //UI Elements
   
    @IBOutlet weak var totalDollars: UILabel!
    @IBOutlet weak var totalLemons: UILabel!
    @IBOutlet weak var totalIceCubes: UILabel!
    
    @IBOutlet weak var dailyPurchaseOfIceLabel: UIBarButtonItem!
    @IBOutlet weak var dailyPurchaseOfLemonsLabel: UIBarButtonItem!
    
        @IBOutlet weak var numberOfLemonsPreferred: UIBarButtonItem!
    @IBOutlet weak var numberOfIceCubesPreferred: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        @IBAction func addLemonForTwoDollars(sender: UIBarButtonItem) {
        
        
//        cashOnHand = cashOnHand - 2
        lemonInventorySubTotal++
        dailyPurchaseOfLemonsLabel.title = "\(lemonInventorySubTotal)"
        
//        totalDollars.text = "\(cashOnHand)"
//        totalLemons.text = "\(lemonInventory)"
//        println("\(cashOnHand) \(lemonInventory)")
        
    }
    @IBAction func subtractLemonForTwoDollars(sender: UIBarButtonItem) {
//        cashOnHand = cashOnHand + 2
        lemonInventorySubTotal--
        dailyPurchaseOfLemonsLabel.title = "\(lemonInventorySubTotal)"

//        totalDollars.text = "\(cashOnHand)"
//        totalLemons.text = "\(lemonInventory)"
//        println("\(cashOnHand) \(lemonInventory)")
    }

    
    @IBAction func addIceCubeForOneDollar(sender: UIBarButtonItem) {
//        cashOnHand = cashOnHand - 1
        iceCubeInventorySubTotal++
        dailyPurchaseOfIceLabel.title = "\(iceCubeInventorySubTotal)"

    
//        totalDollars.text = "\(cashOnHand)"
//        totalIceCubes.text = "\(lemonInventory)"
//        println("\(cashOnHand) \(iceCubeInventory)")
    }
    @IBAction func subtractIceCubeForOneDollar(sender: UIBarButtonItem) {
//        cashOnHand = cashOnHand - 1
        iceCubeInventorySubTotal--
        dailyPurchaseOfIceLabel.title = "\(iceCubeInventorySubTotal)"
        
//        totalDollars.text = "\(cashOnHand)"
//        totalIceCubes.text = "\(lemonInventory)"
//        println("\(cashOnHand) \(iceCubeInventory)")
    }
    
    @IBAction func addLemonPreferred(sender: UIBarButtonItem) {
        lemonMixSubTotal++
        numberOfLemonsPreferred.title = "\(lemonMixSubTotal)"
    }
    @IBAction func subtractLemonPreferred(sender: UIBarButtonItem) {
        lemonMixSubTotal--
        numberOfLemonsPreferred.title = "\(lemonMixSubTotal)"
    }
    
    @IBAction func addIceCubePreferred(sender: UIBarButtonItem) {
        iceMixSubTotal++
        numberOfIceCubesPreferred.title = "\(iceMixSubTotal)"
    }
    
    @IBAction func subtractIceCubePreferred(sender: UIBarButtonItem) {
        iceMixSubTotal--
        numberOfIceCubesPreferred.title = "\(iceMixSubTotal)"
    }

    
    @IBAction func startDay(sender: AnyObject) {
//        enoughMoneyForTheOrder()
        
        let todaysInventoryCost = (lemonInventorySubTotal * 2 + iceCubeInventorySubTotal)
        var dollarsEarnedToday = 0
        
        if cashOnHand >= todaysInventoryCost {
            
            var todaysCustomers: [Double] = []
            var customer = 0.0
            
            let customersToday = Int(arc4random_uniform(UInt32(11)))
            
            
            lemonInventory = lemonInventory + lemonInventorySubTotal
            iceCubeInventory = iceCubeInventory + iceCubeInventorySubTotal
            cashOnHand = cashOnHand - (lemonInventorySubTotal * 2 + iceCubeInventorySubTotal)
            lemonadeRatio = Double(lemonMixSubTotal) / Double(iceMixSubTotal)
            
            if lemonInventory >= lemonMixSubTotal && iceCubeInventory >= iceMixSubTotal {
            
                for var x = 1; x < (customersToday + 1); x++ {
                    customer = (Double(arc4random_uniform(UInt32(11))) / Double(10))
                    todaysCustomers.append(customer)
                }
            
                for customerPreference in todaysCustomers {
                    if customerPreference < 0.4 && lemonadeRatio > 1.0 {
//                    cashOnHand = cashOnHand + 1
                    dollarsEarnedToday++
                    print("You get paid $1")
                    }
                
                    else if (customerPreference >= 0.4 && customerPreference < 0.6) && lemonadeRatio == 1.0 {
//                    cashOnHand = cashOnHand + 1
                    dollarsEarnedToday++
                    print("You get paid $1)")
                    }
                
                    else if customerPreference >= 0.6 && lemonadeRatio < 1.0 {
//                    cashOnHand = cashOnHand + 1
                    dollarsEarnedToday++
                    print("You get paid $1")
                    }
                
                    else {
                        print("The customer doesn't like your lemonade and isn't paying")
                    }
                }
                
//                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: nil, userInfo: nil, repeats: true)
                
                showAlertWithText("Today's Summary", message: "You used \(lemonMixSubTotal) lemons and \(iceMixSubTotal) ice cubes, which costs a total of \(todaysInventoryCost). You earned \(dollarsEarnedToday) today.")
                
                lemonInventory = lemonInventory - lemonMixSubTotal
                iceCubeInventory = iceCubeInventory - iceCubeInventorySubTotal
                cashOnHand = cashOnHand + dollarsEarnedToday
                updateDailyTotals()


            }
            
            else {
                
                showAlertWithText("Warning", message: "The lemonade requires \(lemonMixSubTotal) lemons and \(iceMixSubTotal) ice cubes and you don't have enough. Please either change your mix or order quantities.")
                
            }
            
            
            //        println(customersToday)
            //        println(todaysCustomers)
            
                    }
        
        else {
            
            showAlertWithText("Warning", message: "You don't have enought money to complete your purchase. Please adjust your purchase order accordingly.")
            
        }
        
        
//        println("\(lemonInventory)", "\(iceCubeInventory)", "\(cashOnHand)", "\(lemonadeRatio)")
    }
    
    func updateDailyTotals() {
        
        totalDollars.text = "$\(cashOnHand)"
        totalLemons.text = "\(lemonInventory) Lemons"
        totalIceCubes.text = "\(iceCubeInventory) Ice Cubes"
        dailyPurchaseOfIceLabel.title = "0"
        dailyPurchaseOfLemonsLabel.title = "0"
        numberOfIceCubesPreferred.title = "0"
        numberOfLemonsPreferred.title = "0"
    }
    
//    func enoughMoneyForTheOrder() ->Bool {
//        if cashOnHand >= (lemonInventorySubTotal * 2 + iceCubeInventorySubTotal){
//        return true
//        }
//        else {
//            return false
//        }
//    
//    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        
        let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

