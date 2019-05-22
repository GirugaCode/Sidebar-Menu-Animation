import UIKit

struct MenuItem: Decodable {
	var colorArray: [CGFloat]
	var bigImageName: String
	var imageName: String
}

extension MenuItem {
  var image: UIImage {
    return UIImage(imageLiteralResourceName: imageName)
  }

  var bigImage: UIImage {
    return UIImage(imageLiteralResourceName: bigImageName)
  }

  var color: UIColor {
    return UIColor(colorArray: colorArray)
  }
}
