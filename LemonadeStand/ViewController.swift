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
    
    //UI Elements
    
    @IBOutlet weak var totalDollars: UILabel!
    @IBOutlet weak var lemonsInStock: UILabel!
    @IBOutlet weak var iceCubesInStock: UILabel!
    @IBOutlet weak var numberOfLemonsForTwoDollars: UIBarButtonItem!
    @IBOutlet weak var numberOfLemonsPreferred: UIBarButtonItem!
    @IBOutlet weak var numberOfIceCubesPreferred: UIBarButtonItem!
    
    @IBOutlet weak var numberOfIceCubesForOneDollar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addLemonPreferred(sender: UIBarButtonItem) {
    }
    @IBAction func subtractLemonPreferred(sender: UIBarButtonItem) {
    }
    @IBAction func addLemonForTwoDollars(sender: UIBarButtonItem) {
    }
    @IBAction func subtractLemonForTwoDollars(sender: UIBarButtonItem) {
    }

    @IBAction func addIceCubePreferred(sender: UIBarButtonItem) {
    }
    @IBAction func addIceCubeForOneDollar(sender: UIBarButtonItem) {
    }
    @IBAction func subtractIceCubeForOneDollar(sender: UIBarButtonItem) {
    }
    @IBAction func subtractIceCubePreferred(sender: UIBarButtonItem) {
    }
    
    @IBAction func startDay(sender: AnyObject) {
    }
}

