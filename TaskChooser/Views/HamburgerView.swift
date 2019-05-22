import UIKit

class HamburgerView: UIView {
  
  // Created a UIImageView from the asset libary
  let imageView: UIImageView = {
    let view = UIImageView(image: UIImage(imageLiteralResourceName: "Hamburger"))
    view.contentMode = .center
    return view
  }()
  // Added that Image View, Created a path for both possible init methods
  required override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  private func configure() {
    addSubview(imageView)
  }
  
  // Rotates the view when menu is fully opened
  func setFractionOpen(_ fraction: CGFloat) {
    let angle = fraction * .pi/2.0
    imageView.transform = CGAffineTransform(rotationAngle: angle)
  }

}
