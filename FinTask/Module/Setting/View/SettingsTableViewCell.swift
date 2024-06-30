//
//  SettingsTableViewCell.swift
//  FinTask
//
//  Created by Timofey on 30.06.24.
//

import UIKit

class SettingsTableViewCell: UITableViewCell, CellProtocols {
    static var reuseId: String = "SettingsTableViewCell"
    //UI elements
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
    }
    
}
