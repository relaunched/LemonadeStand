//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Hurewitz, Matthew on 8/3/15.
//  Copyright (c) 2015 Hurewitz, Matthew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cashOnHand = 10
    var lemonInventory = 1
    var iceCubeInventory = 1
    
    var lemonInventorySubTotal = 0
    var iceCubeInventorySubTotal = 0
    
    var lemonMixSubTotal = 0
    var iceMixSubTotal = 0
    
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
        
        lemonInventory = lemonInventory + lemonInventorySubTotal
        iceCubeInventory = iceCubeInventory + iceCubeInventorySubTotal
        println("\(lemonInventory)", "\(iceCubeInventory)")
    }
}

