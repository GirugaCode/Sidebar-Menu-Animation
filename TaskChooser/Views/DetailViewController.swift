import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var backgroundImageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(named: "rw-dark")
  }

  var menuItem: MenuItem? {
    didSet {
      prepare(menuItem)
    }
  }

  func prepare(_ menuItem: MenuItem?) {
    if let newMenuItem = menuItem {
      view.backgroundColor = newMenuItem.color
      backgroundImageView?.image = newMenuItem.bigImage
    }
  }
}
