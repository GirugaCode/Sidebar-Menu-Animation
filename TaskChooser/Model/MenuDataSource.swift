import UIKit

class MenuDataSource: NSObject, UITableViewDataSource {
  private(set) var menuItems: [MenuItem] = []

  override init() {
    super.init()
    prepare()
  }

  func prepare() {
    guard let url = Bundle.main.url(forResource: "MenuItems", withExtension: "json") else {
      assertionFailure("project config error - unable to find MenuItems.json in bundle")
      return
    }
    do {
      let data = try Data(contentsOf: url)
      menuItems = try JSONDecoder().decode([MenuItem].self, from: data)
    } catch {
      assertionFailure("config error - unable to decode json file - \(error)")
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
    -> Int {
    return menuItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell",
                                                   for: indexPath)
      as? MenuItemCell else {
      fatalError("expected to dequeue MenuItemCell - check storyboard")
    }
    let menuItem = menuItems[indexPath.row]
    cell.configureForMenuItem(menuItem)
    return cell
  }
}
