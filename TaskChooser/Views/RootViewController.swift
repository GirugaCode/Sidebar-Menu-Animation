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
  
  var menuViewController: MenuViewController?
  var detailViewController: DetailViewController?

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
    
    menuViewController = setupFromStoryboard("MenuViewController", into: menuContainer) as? MenuViewController
    detailViewController = setupFromStoryboard("DetailViewController", into: detailContainer) as? DetailViewController
    
    menuViewController?.delegate = self
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

extension RootViewController {
  func setupNavigationController(_ rootController: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: rootController)
    
    nav.navigationBar.barTintColor = UIColor(named: "rw-dark")
    nav.navigationBar.tintColor = UIColor(named: "rw-light")
    nav.navigationBar.isTranslucent = false
    nav.navigationBar.clipsToBounds = true
    
    // Sets up the UINavigationController as a child view controller of RootViewController
    // Can be setup properly on any aspect mode
    addChild(nav)
    
    return nav
  }
  
  func setupFromStoryboard (_ identifier: String, into container: UIView) -> UIViewController {
    // Guard Error in case Storyboard breaks
    guard let viewController = storyboard?
      .instantiateViewController(withIdentifier: identifier) else {
        fatalError("broken storyboard expected \(identifier) to be available")
    }
    let nav = setupNavigationController(viewController)
    // Places the view controller inside a UINavigationController and embeds that navigation controller inside the container
    container.embedInsideSafeArea(nav.view)
    return viewController
  }
  
}

extension RootViewController: MenuDelegate {
  /*
   Declares that RootViewController adopts MenuDelegate.
   When you select a menu item, RootViewController tells
   DetailViewController about that change by passing the selected MenuItem to the instance.
   */
  func didSelectMenuItem(_ item: MenuItem) {
    detailViewController?.menuItem = item
  }
}
