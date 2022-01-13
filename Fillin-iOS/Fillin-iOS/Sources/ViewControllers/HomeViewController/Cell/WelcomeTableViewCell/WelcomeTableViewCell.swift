//
//  WelcomeTableViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/12.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.welcomeTableViewCell, bundle: Bundle(for: WelcomeTableViewCell.self))
    }
    
    private func setUI() {
        nickNameLabel.font = .body2
        descriptionLabel.font = .display1
        
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = "서랍 속 잠자는 필름을\n깨워볼까요?"
    }
    
}
