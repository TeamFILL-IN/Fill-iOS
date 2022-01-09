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
    private let backButton = UIButton().then {
        $0.setImage(Asset.btnBack.image, for: .normal)
    }
    
    private let logoButton = UIButton().then {
        $0.setImage(Asset.btnHome.image, for: .normal)
    }
}
