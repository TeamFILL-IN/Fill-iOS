//
//  OnboardingDataModel.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/03/01.
//

import Foundation
import UIKit

struct OnboardingDataModel {
  var imageName: String
  var title: String
  var description: String
  
  init(imageName: String, title: String, description: String) {
      self.imageName = imageName
      self.title = title
      self.description = description
  }
}
