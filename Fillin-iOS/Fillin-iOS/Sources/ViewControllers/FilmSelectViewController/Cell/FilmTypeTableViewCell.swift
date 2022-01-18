//
//  FilmTypeTableViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/19.
//

import UIKit

class FilmTypeTableViewCell: UITableViewCell {
    
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var filmNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override var isSelected: Bool {
        didSet {
            filmNameLabel.textColor = isSelected ? .fillinRed : .fillinWhite
        }
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.filmTypeTableViewCell, bundle: Bundle(for: FilmTypeTableViewCell.self))
    }
    
    private func setUI() {
        filmNameLabel.font = .engDisplay2Book
    }
    
}
