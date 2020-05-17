//
//  OptionCell.swift
//  Coffee Recommendation Engine
//
//  Created by Karthik Venkatesh on 5/16/20.
//  Copyright © 2020 Karthik Venkatesh. All rights reserved.
//

import UIKit

class OptionCell: UICollectionViewCell {
    @IBOutlet var optionLabel: UILabel!
    
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor(hex: "#241401")?.cgColor
    }
    func configureOption(with option: String){
        optionLabel.text = option
    }
}

extension UIColor {
    public convenience init?(hex: String, alpha: CGFloat = 0.75) {
        guard hex.hasPrefix("#") else { return nil }
        
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        
        scanner.scanLocation = 1
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r, g, b: CGFloat
        
        r = CGFloat(Int(color >> 16) & mask) / 255
        g = CGFloat(Int(color >> 8) & mask) / 255
        b = CGFloat(Int(color) & mask) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
