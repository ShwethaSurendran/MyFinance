//
//  ChartTableCell.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 30/11/21.
//

import UIKit
import Charts

class ChartTableCell: UITableViewCell {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var chartView: PieChartView!
    //    @IBOutlet weak var chartView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setChartProperties()
    }
    
    func setChartProperties() {
        chartView.highlightPerTapEnabled = false
        chartView.holeRadiusPercent = Constants.ChartProperties.holeRadius
        chartView.transparentCircleColor = .clear
        chartView.rotationEnabled = false
        chartView.drawEntryLabelsEnabled = false
    }
    
    func setData(model: FinancialProfileModel)  {
        tipLabel.text = model.tip
        drawChart(fromDetails: model)
    }
    
    /// Map data to be shown from the Profile details, Draws Piechart from the mapped data.
    /// - Parameter model: Profile details, from which to draw chart
    private func drawChart(fromDetails model: FinancialProfileModel) {
        let profileCategoryItems: [FinancialProfileItemModel] = model.items.unwrappedValue
        
        ///generate chart data
        let itemNames = profileCategoryItems.compactMap({$0.title})
        let divisions = profileCategoryItems.compactMap({Double($0.value ?? Constants.ChartValue.defaultAmount)})
        
        if divisions.count > 0 && !(model.category == .insurance) {
            self.chartView.isHidden = false
            setupChart(withEntries: itemNames, andValues: divisions)
        }else {
            self.chartView.isHidden = true
        }
    }
    
    /// Setup PieChart with passed entries and values
    /// - Parameters:
    ///   - items: Entries to be displayed in chart
    ///   - divisions: Values corresponding to entries
    private func setupChart(withEntries entries: [String?], andValues divisions: [Double?]) {
        let chartDataSet = getChartDataSet(fromEntries: entries, andValues: divisions)
        let data = PieChartData(dataSet: chartDataSet)
        chartView.data = data
    }
    
    /// Generates PieChartDataSet from given entries and divisions
    /// - Parameters:
    ///   - entries: Entries to be displayed in chart
    ///   - divisions: Values corresponding to entries
    /// - Returns: PieChartDataSet generated from given entries and divisions
    private func getChartDataSet(fromEntries entries: [String?], andValues divisions: [Double?])-> PieChartDataSet {
        ///chart setup
        let dataEntries = getChartDataEntries(fromEntries: entries, andValues: divisions)
        let set = PieChartDataSet( entries: dataEntries, label: "")
        set.valueFont = Constants.ChartProperties.labelFont
        set.valueTextColor = .black
        set.colors = getRandomColors(ofCount: divisions.count)
        set.sliceSpace = Constants.ChartProperties.sliceSpace
        return set
    }
    
    /// Generates PieChartDataEntries from given entries and divisions
    /// - Parameters:
    ///   - entries: Entries to be displayed in chart
    ///   - divisions: Values corresponding to entries
    /// - Returns: Array of PieChartDataEntries generated from given entries and divisions
    private func getChartDataEntries(fromEntries entries: [String?], andValues divisions: [Double?])-> [PieChartDataEntry] {
        var dataEntries = [PieChartDataEntry]()
        for (index, value) in divisions.enumerated() {
            ///Setting chart data entries
            let entry = PieChartDataEntry()
            entry.y = value.unwrappedValue
            entry.label = entries[index]
            dataEntries.append( entry)
        }
        return dataEntries
    }
    
    /// Generates random colors of given count
    /// - Parameter count: Number of colors needs to generate
    /// - Returns: Array of UIColors
    func getRandomColors(ofCount count: Int)-> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<count {
            colors.append(.random())
        }
        return colors
    }
    
}
