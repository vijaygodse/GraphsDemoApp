//
//  BarChartViewController.swift
//  GraphsDemo
//
//  Created by Vijay Godse on 9/16/19.
//  Copyright © 2019 Vijay Godse. All rights reserved.
//

import UIKit

class BarChartViewController: UIViewController {

    @IBOutlet weak var chartView: UIView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private var barChart: BarChart?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBarChartView()
    }
    
    private func configureBarChartView(){
        
        let dataModel = fillBarChartDataModel()
        barChart = BarChart()
        barChart?.initiateGraphView(view: chartView, chartsDataModel: dataModel)
        
        barChart?.buildGraph()
    }
    
    private func fillBarChartDataModel()-> ChartsDataModel{
        let dataModel = ChartsDataModel()
        dataModel.noDataAvailableText = "No Bar chart data available"
        dataModel.YAxisMin = 0
        dataModel.YAxisMax = 100
        dataModel.isDrawBordersEnabled = false
        dataModel.legendText = "Bar Chart"
        return dataModel
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            barChart?.chartViewType = .day
        } else if sender.selectedSegmentIndex == 1 {
            barChart?.chartViewType = .week
        }
        
        barChart?.buildGraph()
    }
}
