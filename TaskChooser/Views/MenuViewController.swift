import UIKit

protocol MenuDelegate: class {
  func didSelectMenuItem(_ item: MenuItem)
}

class MenuViewController: UITableViewController {
  
  let maxCellHeight: CGFloat = 100
  private var datasource: MenuDataSource = MenuDataSource()
  weak var delegate: MenuDelegate? // Weak used to avoid creating a retain cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = datasource
  }

//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let destination = segue.destination as? DetailViewController,
//      let indexPath = tableView.indexPathForSelectedRow {
//      let item = datasource.menuItems[indexPath.row]
//      destination.menuItem = item
//    }
//  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = datasource.menuItems[indexPath.row]
    delegate?.didSelectMenuItem(item)
    
    DispatchQueue.main.async {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }

  override func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
    let proposedHeight = tableView.safeAreaLayoutGuide.layoutFrame.height/CGFloat(datasource.menuItems.count)
    return min(maxCellHeight, proposedHeight)
  }
}
