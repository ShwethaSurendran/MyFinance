//
//  ChartView.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 30/11/21.
//

import UIKit
import Charts

class ChartView: UIView {
    
    init(withFrame frame: CGRect, withEntries items: [String?], andValues divisions: [Double?]) {
        super.init(frame: frame)
        setupChartView(withEntries: items, andValues: divisions)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup PieChart with passed entries and values
    /// - Parameters:
    ///   - items: Entries in chart
    ///   - divisions: Values corresponding to entries
    func setupChartView(withEntries entries: [String?], andValues divisions: [Double?]) {
        let chart = PieChartView(frame: self.frame)
        var dataEntries = [PieChartDataEntry]()
        for (index, value) in divisions.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = value.unwrappedValue
            entry.label = entries[index]
            dataEntries.append( entry)
        }
        
        ///chart setup
        let set = PieChartDataSet( entries: dataEntries, label: "")
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = .black
        
        var colors: [UIColor] = []
        
        for _ in 0..<divisions.count {
            colors.append(.random())
        }
        set.colors = colors
        set.sliceSpace = 1.0
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.highlightPerTapEnabled = false
        chart.holeRadiusPercent = 0.0
        chart.transparentCircleColor = UIColor.clear
        chart.rotationEnabled = false
        
        chart.drawEntryLabelsEnabled = false
        //        chart.usePercentValuesEnabled = true
        
        self.addSubview(chart)
    }
    
}
