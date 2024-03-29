// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let appleLogo = ImageAsset(name: "AppleLogo")
  internal static let basicProfile = ImageAsset(name: "basicProfile")
  internal static let btnAddProfile = ImageAsset(name: "btnAddProfile")
  internal static let btnAddphhoto = ImageAsset(name: "btnAddphhoto")
  internal static let btnBack = ImageAsset(name: "btnBack")
  internal static let btnClear = ImageAsset(name: "btnClear")
  internal static let btnHome = ImageAsset(name: "btnHome")
  internal static let btnHomeFloating = ImageAsset(name: "btnHomeFloating")
  internal static let btnLike = ImageAsset(name: "btnLike")
  internal static let btnLiked = ImageAsset(name: "btnLiked")
  internal static let btnMore = ImageAsset(name: "btnMore")
  internal static let btnOpen = ImageAsset(name: "btnOpen")
  internal static let btnScrap = ImageAsset(name: "btnScrap")
  internal static let btnlogin = ImageAsset(name: "btnlogin")
  internal static let goRightIcon = ImageAsset(name: "goRightIcon")
  internal static let icnAddPhotoBig = ImageAsset(name: "icnAddPhotoBig")
  internal static let icnCall = ImageAsset(name: "icnCall")
  internal static let icnCamera = ImageAsset(name: "icnCamera")
  internal static let icnCategory = ImageAsset(name: "icnCategory")
  internal static let icnClear = ImageAsset(name: "icnClear")
  internal static let icnClearGrey = ImageAsset(name: "icnClearGrey")
  internal static let icnClose = ImageAsset(name: "icnClose")
  internal static let icnClosewhite = ImageAsset(name: "icnClosewhite")
  internal static let icnEdit = ImageAsset(name: "icnEdit")
  internal static let icnFilmRoll = ImageAsset(name: "icnFilmRoll")
  internal static let icnGo = ImageAsset(name: "icnGo")
  internal static let icnHeart = ImageAsset(name: "icnHeart")
  internal static let icnHeartFilled = ImageAsset(name: "icnHeartFilled")
  internal static let icnLink = ImageAsset(name: "icnLink")
  internal static let icnLocation = ImageAsset(name: "icnLocation")
  internal static let icnMap = ImageAsset(name: "icnMap")
  internal static let icnMyLocation = ImageAsset(name: "icnMyLocation")
  internal static let icnMypage = ImageAsset(name: "icnMypage")
  internal static let icnPhoto = ImageAsset(name: "icnPhoto")
  internal static let icnPlaceBig = ImageAsset(name: "icnPlaceBig")
  internal static let icnPlaceSmall = ImageAsset(name: "icnPlaceSmall")
  internal static let icnPrice = ImageAsset(name: "icnPrice")
  internal static let icnSearch = ImageAsset(name: "icnSearch")
  internal static let icnStudio = ImageAsset(name: "icnStudio")
  internal static let icnStudioSelected = ImageAsset(name: "icnStudioSelected")
  internal static let icnTime = ImageAsset(name: "icnTime")
  internal static let icnPlaceBig2 = ImageAsset(name: "icn_place_big2")
  internal static let iconFilmroll = ImageAsset(name: "iconFilmroll")
  internal static let imgOnboardingDot1 = ImageAsset(name: "imgOnboardingDot1")
  internal static let imgOnboardingDot2 = ImageAsset(name: "imgOnboardingDot2")
  internal static let imgOnboardingDot3 = ImageAsset(name: "imgOnboardingDot3")
  internal static let imgPhoto = ImageAsset(name: "imgPhoto")
  internal static let imgTrash = ImageAsset(name: "imgTrash")
  internal static let imgFeedback = ImageAsset(name: "img_feedback")
  internal static let imgonboarding1frame = ImageAsset(name: "imgonboarding1frame")
  internal static let imgonboarding2frame = ImageAsset(name: "imgonboarding2frame")
  internal static let imgonboarding3frame = ImageAsset(name: "imgonboarding3frame")
  internal static let imgtrashRed = ImageAsset(name: "imgtrashRed")
  internal static let intro1 = ImageAsset(name: "intro1")
  internal static let intro2 = ImageAsset(name: "intro2")
  internal static let intro3 = ImageAsset(name: "intro3")
  internal static let iosBtnAddphoto = ImageAsset(name: "iosBtnAddphoto")
  internal static let iosBtnFilmroll = ImageAsset(name: "iosBtnFilmroll")
  internal static let iosBtnMypage = ImageAsset(name: "iosBtnMypage")
  internal static let iosBtnStudiomap = ImageAsset(name: "iosBtnStudiomap")
  internal static let iosCardImg = ImageAsset(name: "iosCardImg")
  internal static let iosCardImgVertical = ImageAsset(name: "iosCardImgVertical")
  internal static let iosCurationCover = ImageAsset(name: "iosCurationCover")
  internal static let iosMapRectangle = ImageAsset(name: "iosMapRectangle")
  internal static let iosPhotoFrame = ImageAsset(name: "iosPhotoFrame")
  internal static let iosPhotoRectangle = ImageAsset(name: "iosPhotoRectangle")
  internal static let iosStatusbar = ImageAsset(name: "iosStatusbar")
  internal static let loginLogo = ImageAsset(name: "loginLogo")
  internal static let logo = ImageAsset(name: "logo")
  internal static let noSearch = ImageAsset(name: "noSearch")
  internal static let photoInsert = ImageAsset(name: "photo_insert")
  internal static let profile = ImageAsset(name: "profile")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
