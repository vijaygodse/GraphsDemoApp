//
//  BarChart.swift
//  GraphsDemo
//
//  Created by Vijay Godse on 9/17/19.
//  Copyright © 2019 Vijay Godse. All rights reserved.
//

import UIKit
import Charts

enum ChartViewType{
    case day
    case week
}

class BarChart: ChartProtocol {
   
    private var chartView = CombinedChartView()
    private var chartsDataModel = ChartsDataModel()
    
    var chartViewType = ChartViewType.day
    
    func initiateGraphView(view: UIView, chartsDataModel: ChartsDataModel) {
        //add combined chart view on UIView
        self.chartView.frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.frame.width, height: view.frame.height)
        view.addSubview(chartView)
        
        self.chartsDataModel = chartsDataModel
        
    }
    
    func buildGraph() {
        
        let combinedData = CombinedChartData()
        var barChartDataSet = BarChartDataSet()
        
            let dataEntries = self.buildBarChartDataEntries()
            barChartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar chart")

        
        barChartDataSet.colors = [UIColor.orange]
        let leftAxisFormatter = self.getValueFormatterForChart()
        barChartDataSet.valueFormatter = DefaultValueFormatter(formatter: leftAxisFormatter)
        barChartDataSet.valueFont = UIFont.systemFont(ofSize: 8)
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartData.barWidth = 0.3
       
        combinedData.barData = barChartData
        self.chartView.data = combinedData
        self.chartView.notifyDataSetChanged()
        //chart animation
        self.chartView.animate(xAxisDuration: 0.0, yAxisDuration: 5, easingOption: .linear)
        
        configureAxis()
        noDataAvailbleText()
        enableDisableLegend()
    }
    
    func updateValue(reading: ChartValueModel) {
        
    }
    
    private func getValueFormatterForChart()-> NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }
    
    private func buildBarChartDataEntries()->[BarChartDataEntry] {
        var dataEntries: [BarChartDataEntry] = []
        var count = 0
        
        switch chartViewType {
        case .day:
            count = 24
        case .week:
            count = 7
        }
        
        for i in 1...count {

            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double.random(in: 0...100))
            dataEntries.append(dataEntry)
            
            
        }
        return dataEntries
    }
    
    //To set default text when no data available to render chart
    private func noDataAvailbleText(){
        chartView.noDataText = chartsDataModel.noDataAvailableText
    }
    
    private func enableDisableLegend(){
        chartView.legend.enabled = chartsDataModel.isLegendEnabled
    }
    
    private func configureAxis(){
        configureXaxis()
        configureYaxis()
        
        //Enable/disable right side labels
        chartView.rightAxis.enabled = chartsDataModel.isRightAxisEnabled
        //add/remove description label
        chartView.chartDescription?.enabled = true//chartsDataModel.ischartDescriptionEnabled
        
        //Enable/disable axis zooming
        chartView.dragEnabled = chartsDataModel.isDragEnabled
        chartView.scaleXEnabled = chartsDataModel.isScaleXEnabled
        chartView.scaleYEnabled = chartsDataModel.isScaleYEnabled
        
        //Enable/disable zooming on double tap
        chartView.doubleTapToZoomEnabled = chartsDataModel.isDoubleTapToZoomEnabled
    }
    
    private func configureXaxis(){
        let xaxis = chartView.xAxis
        
        var axisMaximum = 0.0
        switch chartViewType {
        case .day:
            axisMaximum = 24.5
        case .week:
            axisMaximum = 7.5
        }
        
        xaxis.axisMinimum = 0
        xaxis.axisMaximum = axisMaximum

        //remove x-axis grid labels
        xaxis.drawGridLinesEnabled = chartsDataModel.isDrawGridLinesEnabledForXAxis
        xaxis.labelPosition = chartsDataModel.xAxisLabelPosition
        xaxis.granularity = chartsDataModel.xAxisGranularity
        xaxis.drawAxisLineEnabled = chartsDataModel.isAxisLinesEnabledForXAxis
    }
    
    private func configureYaxis(){
        let yaxis = chartView.leftAxis
        yaxis.drawGridLinesEnabled = chartsDataModel.isDrawGridLinesEnabledForYAxis
        yaxis.drawAxisLineEnabled = chartsDataModel.isAxisLinesEnabledForYAxis
        
        yaxis.gridColor = chartsDataModel.gridColor
        //set extra space to top of Y-axis
        yaxis.spaceTop = chartsDataModel.yAxisTopSpace
        //set the minimum interval between axis values.
        yaxis.granularity = chartsDataModel.yAxisGranularity
        
        //draw y axis values in integer only
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        yaxis.valueFormatter = DefaultAxisValueFormatter(formatter: numberFormatter)
        
        //The borders rectangle will be rendered
        chartView.drawBordersEnabled = chartsDataModel.isDrawBordersEnabled
        
        //Set Y-axis min and max vales
        chartView.leftAxis.axisMinimum = chartsDataModel.YAxisMin
        chartView.leftAxis.axisMaximum = chartsDataModel.YAxisMax
    }
    
}
