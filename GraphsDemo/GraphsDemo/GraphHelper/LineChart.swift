//
//  LineChart.swift
//  GraphsDemo
//
//  Created by Vijay Godse on 9/16/19.
//  Copyright © 2019 Vijay Godse. All rights reserved.
//

import UIKit
import Charts

protocol ChartProtocol {
    func initiateGraphView(view: UIView, chartsDataModel: ChartsDataModel)
    func buildGraph()
    func updateValue(reading: ChartValueModel)
}


class LineChart: ChartProtocol {
    
    private var chartView = CombinedChartView()
    private var chartsDataModel = ChartsDataModel()
    
    private var xAxisIndex = 0
    private var xAxisMinimum: Double = 0
    private var xAxisValueLimit = 10 //max number of entries visble on graph
    //array is required to show time on grpah x axis
    var timeArray: Array<String> = []
    
    private var timer: Timer?
    
    //MARK: PulseChartProtocol implementation methods
    func initiateGraphView(view: UIView, chartsDataModel: ChartsDataModel) {
        //add combined chart view on UIView
        self.chartView.frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.frame.width, height: view.frame.height)
        view.addSubview(chartView)
        
        self.chartsDataModel = chartsDataModel
        
        configureAxis()
       
        noDataAvailbleText()
        enableDisableLegend()
    }
    
    func buildGraph(){
        let lineChartDataSet: LineChartDataSet = LineChartDataSet(entries: [ChartDataEntry](), label: chartsDataModel.legendText)
        updateLineChartDataSet(lineChartDataSet)
        let lineData = LineChartData(dataSets: [lineChartDataSet])
        lineData.setDrawValues(chartsDataModel.showDrawValues)
        let combinedData = CombinedChartData()
        combinedData.lineData = lineData
        chartView.data = combinedData
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateChart), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func updateChart() {
        //update value
        
        let lineChartDataModel = LineChartDataModel()
        lineChartDataModel.value = Double.random(in: 70...90)
        lineChartDataModel.datetime = Date()
        
        self.updateValue(reading: lineChartDataModel)
    }
    
    func updateValue(reading: ChartValueModel) {
        
        
        if let datetime = reading.datetime, let yValue = (reading as? LineChartDataModel)?.value {
            updateTimeArray(readingDateTime: datetime)
            
            chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: timeArray)
            
            chartView.data?.addEntry(ChartDataEntry(x: Double(xAxisIndex), y: yValue), dataSetIndex: 0)
        }
        //if values exceed xAxisValueLimit then update axisMinimum by 1 and axisMaximum by index + 2
        if xAxisIndex >= xAxisValueLimit{
            xAxisMinimum += 1
            chartView.xAxis.axisMinimum = xAxisMinimum
            if UIDevice.current.userInterfaceIdiom == .phone {
                chartView.xAxis.axisMaximum = Double(xAxisIndex + 1)
            }
            chartView.xAxis.axisMaximum = Double(xAxisIndex + 2)
        }
        else{
            chartView.xAxis.axisMaximum = Double(xAxisValueLimit)
        }
        
        chartView.moveViewToX(Double(xAxisIndex))
        chartView.notifyDataSetChanged()
        xAxisIndex += 1
    }
    
    private func updateTimeArray(readingDateTime: Date){
        //Add reading time in timeArray
        let timeString = UIUtils.convertDateToString(date: readingDateTime, format: "HH:mm:ss")
        self.timeArray.append(timeString)
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
    
    private func updateLineChartDataSet(_ lineChartDataSet: LineChartDataSet){
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.setColor(chartsDataModel.lineColor)
//        lineChartDataSet.drawVerticalHighlightIndicatorEnabled = false
//        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        lineChartDataSet.lineWidth = chartsDataModel.lineWidth
    }
    
}
