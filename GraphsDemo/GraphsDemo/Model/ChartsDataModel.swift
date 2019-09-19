//
//  ChartModel.swift
//  GraphsDemo
//
//  Created by Vijay Godse on 9/16/19.
//  Copyright © 2019 Vijay Godse. All rights reserved.
//

import Foundation
import Charts

public class ChartsDataModel{
    var noDataAvailableText: String
    var isRightAxisEnabled: Bool
    var ischartDescriptionEnabled: Bool
    var isDragEnabled: Bool
    var isScaleXEnabled: Bool
    var isScaleYEnabled: Bool
    var isDoubleTapToZoomEnabled: Bool
    var isDrawGridLinesEnabledForXAxis: Bool
    var isDrawGridLinesEnabledForYAxis: Bool
    var isAxisLinesEnabledForXAxis: Bool
    var isAxisLinesEnabledForYAxis: Bool
    var xAxisLabelPosition: XAxis.LabelPosition
    var isDrawBordersEnabled: Bool
    var xAxisGranularity: Double
    var yAxisGranularity: Double
    var yAxisTopSpace: CGFloat
    var YAxisMin: Double
    var YAxisMax: Double
    var legendText: String
    var gridColor: UIColor
    var lineWidth: CGFloat
    var lineColor: UIColor
    var isLegendEnabled: Bool
    var showDrawValues: Bool
    
    
    init() {
        self.noDataAvailableText = ""
        self.isRightAxisEnabled = false
        self.ischartDescriptionEnabled = false
        self.isDragEnabled = true
        self.isScaleXEnabled = true
        self.isScaleYEnabled = true
        self.isDoubleTapToZoomEnabled = false
        self.isDrawGridLinesEnabledForXAxis = false
        self.isDrawGridLinesEnabledForYAxis = true
        self.isAxisLinesEnabledForXAxis = true
        self.isAxisLinesEnabledForYAxis = false
        self.xAxisLabelPosition = .bottom
        self.isDrawBordersEnabled = false
        self.xAxisGranularity = 1 //minimum interval between x axis values
        self.yAxisGranularity = 5 //minimum interval between y axis values
        self.yAxisTopSpace = 0.5 //extra space to top of Y-axis
        self.YAxisMin = 60  //The minimum value for this axis
        self.YAxisMax = 110 //The maximum value for this axis
        self.legendText = ""
        self.gridColor = .lightGray
        self.lineWidth = 1.0
        self.lineColor = UIColor.blue
        self.isLegendEnabled = true
        self.showDrawValues = true
        
    }
    
}


class LineChartDataModel: ChartValueModel {
    var value: Double?
}

class ChartValueModel {
    var datetime: Date?
}
