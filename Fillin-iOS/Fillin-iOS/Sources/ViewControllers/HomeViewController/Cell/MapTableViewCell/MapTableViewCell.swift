//
//  MapTableViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/12.
//

import UIKit

class MapTableViewCell: UITableViewCell {

    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.mapTableViewCell, bundle: Bundle(for: MapTableViewCell.self))
    }
}