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
    @IBOutlet weak var chartView: UIView!
    let chartHeight: CGFloat = 450
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(model: FinancialProfileModel)  {
        tipLabel.text = model.tip
        drawChart(fromDetails: model)
    }
    
    /// Map data to be shown from the Profile details, Draws Piechart from the mapped data.
    /// - Parameter model: Profile details, from which to draw chart
    func drawChart(fromDetails model: FinancialProfileModel) {
        let profileCategoryItems: [FinancialProfileItemModel] = model.items.unwrappedValue
        
        ///generate chart data
        let itemNames = profileCategoryItems.compactMap({$0.title})
        let divisions = profileCategoryItems.compactMap({Double($0.value ?? "0")})
        
        if divisions.count > 0 && !(model.category == .insurance) {
            let chart = ChartView.init(withFrame: CGRect.init(x: chartView.frame.origin.x, y: chartView.frame.origin.y, width: self.frame.width - 80, height: chartHeight), withEntries: itemNames, andValues: divisions)
            self.chartView.isHidden = false
            self.chartView.addSubview(chart)
        }else {
            self.chartView.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        self.chartView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
}
