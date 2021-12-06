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
    
    var viewModel: ChartViewModel? = nil
    
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
        viewModel = ChartViewModel.init(profileDetails: model)
        tipLabel.text = viewModel?.profileModel?.tip
        drawChart()
    }
    
    ///Ask ViewModel to get data for PieChart and draw if any.
    private func drawChart() {
        if (viewModel?.shouldDrawChart()).unwrappedValue {
            self.chartView.isHidden = false
            chartView.data = viewModel?.getPieChartData()
        }else {
            self.chartView.isHidden = true
        }
    }

}
