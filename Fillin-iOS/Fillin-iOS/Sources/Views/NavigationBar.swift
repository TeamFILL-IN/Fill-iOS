//
//  NavigationBar.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/10.
//

import Foundation
import SnapKit
import Then

/*
 공통으로 사용할 수 있도록 만들어둔 네비게이션 바 입니다.
 
 1) NavigationBar에는 공통으로 필요한 요소들을 구현해둔 상태
 2) NavigationBar를 상속받은 뷰 생성

*/

class NavigationBar: UIView {
    
    // MARK: - Properties
    
    private let backButton = UIButton().then {
        $0.setImage(Asset.btnBack.image, for: .normal)
        $0.addTarget(self, action: #selector(touchBackButton(_:)), for: .touchUpInside)
    }
    
    private let logoButton = UIButton().then {
        $0.setImage(Asset.btnHome.image, for: .normal)
        $0.addTarget(self, action: #selector(touchLogoButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
        setupAutoLayout()
    }
    
    // MARK: - Custom Method
    
    private func configUI() {
        backgroundColor = .fillinBlack
    }
    
    private func setupAutoLayout() {
        addSubviews([backButton, logoButton])
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
        
        logoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(86)
            make.height.equalTo(32)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchBackButton(_ sender: UIButton) {
        print("touchBackButton")
    }
    
    @objc func touchLogoButton(_ sender: UIButton) {
        print("touchLogoButton")
    }
}
