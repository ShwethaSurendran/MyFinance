//
//  ChartViewModel.swift
//  MyFinance
//
//  Created by Shwetha Surendran on 05/12/21.
//

import UIKit
import Charts


struct ChartViewModel {
    
    var profileModel: FinancialProfileModel?
    
    init(profileDetails model: FinancialProfileModel) {
        profileModel = model
    }
    
    /// Check if need to draw chart, based on user given values
    /// - Returns: Boolean value indicating that chart should be drawn or not.
    func shouldDrawChart()-> Bool {
        let entriesAndDivisions: (entries: [String], divisions: [Double]) = getProfileEntriesAndDivisions()
        return (entriesAndDivisions.divisions.count > 0 && !(profileModel?.category == .insurance))
    }
    
    /// Creates list of profile category items and corresponding User given values
    /// - Returns: Array of items and User entries
    private func getProfileEntriesAndDivisions()-> ([String], [Double]) {
        let profileCategoryItems: [FinancialProfileItemModel] = (profileModel?.items).unwrappedValue
        let itemNames = profileCategoryItems.compactMap({model in
            model.value == "" ? nil : model.title
        })
        let divisions = profileCategoryItems.compactMap({Double($0.value ?? Constants.ChartValue.defaultAmount)})
        return (itemNames, divisions)
    }
    
    /// Generates PieChartData, that needs to be shown in Chart.
    /// - Returns: PieChartData generated from User given details
    func getPieChartData()-> PieChartData {
        let chartDataSet = getPieChartDataSet()
        let data = PieChartData(dataSet: chartDataSet)
        return data
    }
    
    /// Generates PieChartDataSet from ProfileModel
    /// - Returns: PieChartDataSet generated from given entries and divisions
    private func getPieChartDataSet()-> PieChartDataSet {
        let entriesAndDivisions: (entries: [String], divisions: [Double]) = getProfileEntriesAndDivisions()
        ///chart setup
        let dataEntries = getPieChartDataEntries(fromEntries: entriesAndDivisions.entries, andValues: entriesAndDivisions.divisions)
        let set = PieChartDataSet( entries: dataEntries, label: "")
        set.valueFont = Constants.ChartProperties.labelFont
        set.valueTextColor = .black
        set.colors = getRandomColors(ofCount: entriesAndDivisions.divisions.count)
        set.sliceSpace = Constants.ChartProperties.sliceSpace
        return set
    }
    
    /// Generates PieChartDataEntries from given entries and divisions
    /// - Parameters:
    ///   - entries: Entries to be displayed in chart
    ///   - divisions: Values corresponding to entries
    /// - Returns: Array of PieChartDataEntries generated from given entries and divisions
    private func getPieChartDataEntries(fromEntries entries: [String?], andValues divisions: [Double?])-> [PieChartDataEntry] {
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
    private func getRandomColors(ofCount count: Int)-> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<count {
            colors.append(.random())
        }
        return colors
    }
    
}
