# ๐ธFill-iOS

<img width="1280" alt="iMac - 1" src="https://user-images.githubusercontent.com/63863135/148956606-59192e40-64ea-4c04-a0cf-07edc80492db.jpg">
<img src="https://user-images.githubusercontent.com/54793607/150477388-7589d8f1-7a20-49d8-a3e8-0cef7a0a3392.gif">
<br>

## <img width=25px src=https://user-images.githubusercontent.com/63863135/148947996-b33a1bca-b668-4331-93b2-dcf78d3c63f5.png>  Project
**Fill-in your Film, Fill-IN**
> **SOPT 29th APPJAM**  
> **ํ๋ก์ ํธ ๊ธฐ๊ฐ : 2022.01.03~ 2022.01.22**  
> 
> **ํ๋ฆ์นด๋ฉ๋ผ ํ์์, ํ๋ฆ ์ ๋ณด์ ๊ณต ์๋น์ค Fill-in**  


<br>


## ๐Fill-In iOS Developers

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/dlwns33"><img src="https://user-images.githubusercontent.com/63863135/148957472-d6757fe0-5bae-4d08-8fba-b58a518764cb.png" width="220px;" alt=""/><br /><titleb><b>dlwns33</b></titleb></a><br /><a href="https://github.com/TeamFILL-IN/Fill-iOS/commits?author=dlwns33" title="Code">๐ฑ</a></td>
    <td align="center"><a href="https://github.com/Kim-jisoo11"><img src="https://user-images.githubusercontent.com/63863135/148957873-1e811f38-6665-42e8-aebf-d67c4c9ce560.png" width="220px;" alt=""/><br /><titleb><b>Kim-jisoo11</b></titleb></a><br /><a href="https://github.com/TeamFILL-IN/Fill-iOS/commits?author=Kim-jisoo11" title="Code" title="Code">๐ฑ</a></td>
    <td align="center"><a href="https://github.com/jumining"><img src="https://user-images.githubusercontent.com/63863135/148959657-b0903307-f1b9-4b5e-a8cc-033975448fef.png" width="220px;" alt=""/><br /><titleb><b>jumining</b></titleb></a><br /><a href="https://github.com/TeamFILL-IN/Fill-iOS/commits?author=jumining" title="Code">๐ฑ</a></td>
  </tr>
</table>

<br>


## Coding Convention
<details>
<summary>ํ๋ฆฐ ์์๋ค์ ์ฝ๋ฉ ์ปจ๋ฒค์ ๋ณด๊ธฐ</summary>
<div markdown="1">
  
## **์ํฌํธ**

๋ชจ๋ ์ํฌํธ๋ ์ํ๋ฒณ ์์ผ๋ก ์ ๋ ฌํฉ๋๋ค. ๋ด์ฅ ํ๋ ์์ํฌ๋ฅผ ๋จผ์  ์ํฌํธํ๊ณ , ๋น ์ค๋ก ๊ตฌ๋ถํ์ฌ ์๋ํํฐ ํ๋ ์์ํฌ๋ฅผ ์ํฌํธํฉ๋๋ค.

```swift
import UIKit

import SwiftyColor
import SwiftyImage
import Then
import URLNavigator
```

### UpperCamalCase

- ํด๋์ค
- ๊ตฌ์กฐ์ฒด
- ์ต์คํ์
- ํ๋กํ ์ฝ
- ์ด๊ฑฐํ

### lowerCamelCase

- ํจ์
- ๋ฉ์๋
- ์ธ์คํด์ค

### **์๋ฒํต์ **

์๋น์คํจ์๋ช(postOnboarding) + WithAPI

### **IBAction**

๋์ฌ์ํ + ๋ชฉ์ ์ด ex) touchBackButton

### **๋ทฐ ์ ํ**

pop, push, present, dismiss

๋์ฌ + To + ๋ชฉ์ ์ง ๋ทฐ (๋ค์์ ๋ณด์ผ ๋ทฐ)

( dismiss๋ dismiss + ํ์ฌ ๋ทฐ )

### **์ ๋๋ฉ์ด์**

- ๋์ฌ์ํ + ๋ชฉ์ ์ด + WithAnimation
- showButtonsWithAnimation

### **register**

- register + ๋ชฉ์ ์ด
- registerXib

### **subview๋ก ๋ถ์ด๊ธฐ**

- attatch

### **ํ๋กํ ์ฝ**

- ๋ทฐ ์ด๋ฆ + View + Delegate

## **MARK ์ฃผ์**

**// MARK: - Properties**

**// MARK: - @IBOutlet Properties**

**// MARK: - @IBAction Properties**

**// MARK: - View Life Cycle**

**// MARK: - Extensions**

**// MARK: - UITableViewDataSource**

**// MARK: - UITableViewDelegate**ย ํ๋กํ ์ฝ๋ค Extension ์ผ๋ก ๋นผ๊ธฐ

// TODO: -

// FIXME: -

### **๊ธฐํ๊ท์น**

- `self`๋ ์ต๋ํ ์ฌ์ฉ์ย **์ง์**
- `viewDidLoad()`์์๋ย **ํจ์ํธ์ถ๋ง**
    - delegate ์ง์ , UI๊ด๋ จ ์ค์  ๋ฑ๋ฑ ๋ชจ๋ ํจ์๋ก
- ํจ์๋ย `extension`์ ์ ์ํ๊ณ  ์ ๋ฆฌ
    - `extension`์ ๋ชฉ์ ์ ๋ฐ๋ผ ๋ถ๋ฅ
    - `extension`์ ๊ฐ์ ํ์์ ๋ฐ๋ผ ์ฌ์ฉ โ delegate, datasource ๋ ๋นผ๋ณด๊ธฐ
- { ์ฌ์ฉ๋ฒ
    
    ```swift
    enum Result {
      case .success
      case .failure
    }
    ```
<br>

</div>
</details>

## Git Branch ์ ๋ต
<details>
<summary>ํ๋ฆฐ ์์๋ค์ ๊น ๋ธ๋์น ์ ๋ต ๋ณด๊ธฐ</summary>
<div markdown="1">
 
  ## main : ์์ฑ๋ณธ, ๊ฑด๋๋ฆฌ์ง ์์ต๋๋ค 

  ### develop : ๊ฐ๋ฐ ์ค ๋ํดํธ ๋ธ๋์น๋ก ์ค์ ํฉ๋๋ค.

  ### feature/#์ด์๋๋ฒ ๋ก ๋ธ๋์น ์์ฑ ํ ํ๋ฆฌํ๋ก ํฉ์น๋ฉด ๋ธ๋์น๋ฅผ ์ญ์ ํฉ๋๋ค.
  ex: feature/#34
  
  ### ๐๊ฐ๋จํ์ฅฌ?
</div>
</details>

## Foldering Convention
<details>
<summary>ํ๋ฆฐ ์์๋ค์ ํด๋๋ง ์ปจ๋ฒค์ ๋ณด๊ธฐ</summary>
<div markdown="1">

  
๐ Resource
   
    - ...
   
    - Assets
  
        - Assets.xcassets

    - Constants

    - Extensions
  
    - Fonts

   
๐ Source
    - AppDelegate

    - SceneDelegate

    - Classes

    - Models

    - NetworkService
   
    - Protocols
  
    - Views
  
    - ViewControllers

        - HomeviewControllers / ๐ : ๋ทฐ ๋จ์๋ก ํด๋๋ง
  
        - HomeviewController.xib : xib ํ์ผ
  
        - HomeViewController.swift : ๋ทฐ ์ปจํธ๋กค๋ฌ(xib์ค 1๋1 ๋งค์นญ)
  
        - Cell / ๐ : ์ ๊ด๋ ค ํ์ผ ์ ์ฅ Like CollectionView Cells, TableView Cells
  
        - DataModel / ๐ : ๋ฐ์ดํฐ ๋ชจ๋ฐ ์ ์ฅ (ex. ~Request.swift - ๋ณด๋ด๋๊ฑฐ, ~Response.swift - ๋ฐ๋๊ฑฐ
</div>
</details>
<br>

## ๐ FILL-IN iOS Notion

### ๐ [FILL-IN iOS Notion ๋ฐ๋ก๊ฐ๊ธฐ](https://66jxndoe.notion.site/FILL-IN-iOS-427dc5904bf24a5eb62daebf6b4f783d)

<br>

## ๐ FILL-IN iOS KANBAN BOARD

### ๐ [FILL-IN KANBAN BOARD ๋ฐ๋ก๊ฐ๊ธฐ](https://github.com/TeamFILL-IN/Fill-iOS/projects/1)

<br>

## ํ๋ฆฐ์ด๋ค์ Task๋ถ๋ฐฐ

| ๊ธฐ๋ฅ | ๊ฐ๋ฐ ์ฌ๋ถ | ๋ด๋น์ |
|:----------|:----------:|:----:|
| Main Home | ๐ธ | ์ด์ค |
| Home Map | ๐ธ | ์ด์ค |
| Add Photo | ๐ธ | ์ง์ |
| Film Roll | ๐ธ | ์ด์ค |
| Studio Map | ๐ธ | ์ฃผ๋ฏผ |
| Add Photo | ๐ธ | ์ง์ |
| My Page | ๐ธ | ์ง์ |


<br>
