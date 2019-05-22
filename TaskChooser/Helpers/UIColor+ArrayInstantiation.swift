import UIKit

extension UIColor {
  convenience init(colorArray array: [CGFloat]) {

    var source = array
    if array.count != 3 {
      source = [255, 255, 255]
    }

    let red = source[0]/255
    let green = source[1]/255
    let blue = source[2]/255
    self.init(red: red, green: green, blue: blue, alpha: 1.0)
  }
}
