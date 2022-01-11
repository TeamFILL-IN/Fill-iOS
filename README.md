# 📸Fill-iOS

<img width="1280" alt="iMac - 1" src="https://user-images.githubusercontent.com/63863135/148956606-59192e40-64ea-4c04-a0cf-07edc80492db.jpg">

## <img width=25px src=https://user-images.githubusercontent.com/63863135/148947996-b33a1bca-b668-4331-93b2-dcf78d3c63f5.png>  Project
**Fill-in your Film, Fill-IN**
> **SOPT 29th APPJAM**  
> **프로젝트 기간 : 2022.01.03~ 2022.01.22**  
> 
> **필름카메라 현상소, 필름 정보제공 서비스 Fill-in**  


<br>


## 🍎Fill-In iOS Developers

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/dlwns33"><img src="https://user-images.githubusercontent.com/63863135/148957472-d6757fe0-5bae-4d08-8fba-b58a518764cb.png" width="220px;" alt=""/><br /><titleb><b>dlwns33</b></titleb></a><br /><a href="https://github.com/TeamFILL-IN/Fill-iOS/commits?author=dlwns33" title="Code">📱</a></td>
    <td align="center"><a href="https://github.com/Kim-jisoo11"><img src="https://user-images.githubusercontent.com/63863135/148957873-1e811f38-6665-42e8-aebf-d67c4c9ce560.png" width="220px;" alt=""/><br /><titleb><b>Kim-jisoo11</b></titleb></a><br /><a href="https://github.com/TeamFILL-IN/Fill-iOS/commits?author=Kim-jisoo11" title="Code" title="Code">📱</a></td>
    <td align="center"><a href="https://github.com/jumining"><img src="https://user-images.githubusercontent.com/63863135/148959657-b0903307-f1b9-4b5e-a8cc-033975448fef.png" width="220px;" alt=""/><br /><titleb><b>jumining</b></titleb></a><br /><a href="https://github.com/TeamFILL-IN/Fill-iOS/commits?author=jumining" title="Code">📱</a></td>
  </tr>
</table>

<br>


## Coding Convention
<details>
<summary>필린 아요들의 코딩 컨벤션 보기</summary>
<div markdown="1">
  
## **임포트**

모듈 임포트는 알파벳 순으로 정렬합니다. 내장 프레임워크를 먼저 임포트하고, 빈 줄로 구분하여 서드파티 프레임워크를 임포트합니다.

```swift
import UIKit

import SwiftyColor
import SwiftyImage
import Then
import URLNavigator
```

### UpperCamalCase

- 클래스
- 구조체
- 익스텐션
- 프로토콜
- 열거형

### lowerCamelCase

- 함수
- 메서드
- 인스턴스

### **서버통신**

서비스함수명(postOnboarding) + WithAPI

### **IBAction**

동사원형 + 목적어 ex) touchBackButton

### **뷰 전환**

pop, push, present, dismiss

동사 + To + 목적지 뷰 (다음에 보일 뷰)

( dismiss는 dismiss + 현재 뷰 )

### **애니메이션**

- 동사원형 + 목적어 + WithAnimation
- showButtonsWithAnimation

### **register**

- register + 목적어
- registerXib

### **subview로 붙이기**

- attatch

### **프로토콜**

- 뷰 이름 + View + Delegate

## **MARK 주석**

**// MARK: - Properties**

**// MARK: - @IBOutlet Properties**

**// MARK: - @IBAction Properties**

**// MARK: - View Life Cycle**

**// MARK: - Extensions**

**// MARK: - UITableViewDataSource**

**// MARK: - UITableViewDelegate** 프로토콜들 Extension 으로 빼기

// TODO: -

// FIXME: -

### **기타규칙**

- `self`는 최대한 사용을 **지양**
- `viewDidLoad()`에서는 **함수호출만**
    - delegate 지정, UI관련 설정 등등 모두 함수로
- 함수는 `extension`에 정의하고 정리
    - `extension`은 목적에 따라 분류
    - `extension`은 각자 필요에 따라 사용 → delegate, datasource 는 빼보기
- { 사용법
    
    ```swift
    enum Result {
      case .success
      case .failure
    }
    ```
<br>

</div>
</details>

## Git Branch 전략
<details>
<summary>필린 아요들의 깃 브랜치 전략 보기</summary>
<div markdown="1">
 
  ## main : 완성본, 건드리지 않습니다 

  ### develop : 개발 중 디폴트 브랜치로 설정합니다.

  ### feature/#이슈넘버 로 브랜치 생성 후 풀리퀘로 합치면 브랜치를 삭제합니다.
  ex: feature/#34
  
  ### 🍎간단하쥬?
</div>
</details>

## Foldering Convention
<details>
<summary>필린 아요들의 폴더링 컨벤션 보기</summary>
<div markdown="1">

  
🗂 Resource
   
    - ...
   
    - Assets
  
        - Assets.xcassets

    - Constants

    - Extensions
  
    - Fonts

   
🗂 Source
    - AppDelegate

    - SceneDelegate

    - Classes

    - Models

    - NetworkService
   
    - Protocols
  
    - Views
  
    - ViewControllers

        - HomeviewControllers / 🗂 : 뷰 단위로 폴더링
  
        - HomeviewController.xib : xib 파일
  
        - HomeViewController.swift : 뷰 컨트롤러(xib오 1대1 매칭)
  
        - Cell / 🗂 : 셀 관려 파일 저장 Like CollectionView Cells, TableView Cells
  
        - DataModel / 🗂 : 데이터 모데 저장 (ex. ~Request.swift - 보내는거, ~Response.swift - 받는거
</div>
</details>
<br>



## 필린이들의 Task분배

| 기능 | 개발 여부 | 담당자 |
|:----------|:----------:|:----:|
| 홈 || 최이준 |
| 지도맵 |📸| 임주민 |
| 필름롤 || 최이준 |
| 마이페이지 || 김지수 |

<br>
