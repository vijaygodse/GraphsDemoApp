//
//  HomeViewController.swift
//  GraphsDemo
//
//  Created by Vijay Godse on 9/16/19.
//  Copyright © 2019 Vijay Godse. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showBarChart(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "BarChartViewController") as? BarChartViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func showLineChart(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "LineChartViewController") as? LineChartViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

