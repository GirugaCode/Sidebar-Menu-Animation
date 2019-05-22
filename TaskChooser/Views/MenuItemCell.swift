import UIKit

class MenuItemCell: UITableViewCell {
  @IBOutlet weak var menuItemImageView: UIImageView!

  func configureForMenuItem(_ menuItem: MenuItem) {
    menuItemImageView.image = menuItem.image
    backgroundColor = menuItem.color
  }
}
