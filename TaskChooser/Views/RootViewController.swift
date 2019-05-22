import UIKit

extension UIView {
  // A helper function that adds the passed-in view as a subview
  func embedInsideSafeArea (_ subview: UIView) {
    addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
    subview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
    subview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
    subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
  }
}

class RootViewController: UIViewController {

  lazy var scroller: UIScrollView = {
    let scroller = UIScrollView(frame: .zero)
    scroller.isPagingEnabled = true
    scroller.delaysContentTouches = false
    scroller.bounces = false
    scroller.showsHorizontalScrollIndicator = false
    scroller.delegate = self
    return scroller
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(named: "rw-dark")
    // Uses the extension helper to constrain to view
    view.embedInsideSafeArea(scroller)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension RootViewController: UIScrollViewDelegate {
}
