//
//  TabBarTableViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/12.
//

import UIKit

class TabBarTableViewCell: UITableViewCell {

    // MARK: - Properties
    var pushToAddPhotoViewController: (() -> Void)?
    var pushToFilmRollViewController: (() -> Void)?
    var pushToStudioMapViewController: (() -> Void)?
    var pushToMyPageViewController: (() -> Void)?
    
    // MARK: - @IBAction Properties
    @IBAction func touchAddPhoto(_ sender: Any) {
        pushToAddPhotoViewController?()
    }
    
    @IBAction func touchFilmRoll(_ sender: Any) {
        pushToFilmRollViewController?()
    }
    
    @IBAction func touchStudioMap(_ sender: Any) {
        pushToStudioMapViewController?()
    }
    
    @IBAction func touchMyPage(_ sender: Any) {
        pushToMyPageViewController?()
    }
    
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
        return UINib(nibName: Const.Xib.tabBarTableViewCell, bundle: Bundle(for: TabBarTableViewCell.self))
    }
    
}
