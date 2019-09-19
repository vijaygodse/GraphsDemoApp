//
//  LineChartViewController.swift
//  GraphsDemo
//
//  Created by Vijay Godse on 9/16/19.
//  Copyright © 2019 Vijay Godse. All rights reserved.
//

import UIKit

class LineChartViewController: UIViewController {

    @IBOutlet weak var chartView: UIView!
    private var lineChart: LineChart?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureLineChartView()
    }
    
    private func configureLineChartView(){
        
        let dataModel = fillLineChartDataModel()
        lineChart = LineChart()
        lineChart?.initiateGraphView(view: chartView, chartsDataModel: dataModel)
        
        lineChart?.buildGraph()
    }
    
    private func fillLineChartDataModel()-> ChartsDataModel{
        let dataModel = ChartsDataModel()
//        dataModel.noDataAvailableText = ""
        dataModel.YAxisMin = 60
        dataModel.YAxisMax = 100
        dataModel.lineColor = UIColor.orange
        dataModel.lineWidth = 3.0
        dataModel.isDrawBordersEnabled = false
        dataModel.legendText = "Line Chart"
        return dataModel
    }

}
