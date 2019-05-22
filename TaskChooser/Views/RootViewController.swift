import UIKit

extension UIView {
  // A helper function that adds the passed-in view as a subview
  func embedInsideSafeArea (_ subview: UIView) {
    addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      subview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      subview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
      ])
  }
}

class RootViewController: UIViewController {
  
  let menuWidth: CGFloat = 80.0
  
  var menuContainer = UIView(frame: .zero)
  var detailContainer = UIView(frame: .zero)

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
    view.embedInsideSafeArea(scroller)  // Uses the extension helper to constrain to view
    
    setupMenuContainer()
    setupDetailContainer()
  }
  
  func setupMenuContainer() {
    scroller.addSubview(menuContainer)
    menuContainer.translatesAutoresizingMaskIntoConstraints = false
    menuContainer.backgroundColor = .orange
    
    
    NSLayoutConstraint.activate([
        menuContainer.leadingAnchor.constraint(equalTo: scroller.leadingAnchor),
        menuContainer.topAnchor.constraint(equalTo: scroller.topAnchor),
        menuContainer.bottomAnchor.constraint(equalTo: scroller.bottomAnchor),
      
        menuContainer.widthAnchor.constraint(equalToConstant: menuWidth),
        menuContainer.heightAnchor.constraint(equalTo: scroller.heightAnchor)
      ])

  }
  
  func setupDetailContainer() {
    scroller.addSubview(detailContainer)
    detailContainer.translatesAutoresizingMaskIntoConstraints = false
    detailContainer.backgroundColor = .red
    
    NSLayoutConstraint.activate([
        detailContainer.trailingAnchor.constraint(equalTo: scroller.trailingAnchor),
        detailContainer.topAnchor.constraint(equalTo: scroller.topAnchor),
        detailContainer.bottomAnchor.constraint(equalTo: scroller.bottomAnchor),
      
        detailContainer.leadingAnchor.constraint(equalTo: menuContainer.trailingAnchor),
        detailContainer.widthAnchor.constraint(equalTo: scroller.widthAnchor)
      ])
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension RootViewController: UIScrollViewDelegate {
}
