import UIKit

final class TabBarController: UITabBarController {
    
    lazy var buttonMiddle: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.backgroundColor = UIColor(hex: "#129575FF")
        let imgView = UIImageView(image: UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal))
        btn.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgView.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            imgView.widthAnchor.constraint(equalTo: btn.widthAnchor, multiplier: 0.5),
            imgView.heightAnchor.constraint(equalTo: btn.heightAnchor, multiplier: 0.5)
        ])
        
        btn.addAction(UIAction {_ in print("Tapped.")}, for: .touchUpInside)
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        btn.layer.cornerRadius = 30
        return btn
    }()
    
    @objc private func btnTapped() {
        print("buttonTapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        buttonMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width / 2 - 30), y: -40, width: 60, height: 60)
    }
    
    override func loadView() {
        super.loadView()
        setupTabBar()
        setupButton()
        
        let yourView = self.tabBar
        yourView.layer.shadowColor = UIColor.black.cgColor
        yourView.layer.shadowOpacity = 0.3
        yourView.layer.shadowOffset = CGSize(width: 0.0, height: -1.0)
        yourView.layer.shadowRadius = 1.0
    }
    
    private func setupViewControllers() {
        let mainVC = UINavigationController(rootViewController: HomeViewController())
        let bookmarksNav = UINavigationController(rootViewController: BookmarksViewController())
        let addRecipeNav = UINavigationController(rootViewController: AddRecipeViewController())
        let notificationsNav = UINavigationController(rootViewController: NotificationsViewController())
        let profileNav = UINavigationController(rootViewController: ProfileViewController())
        
        setViewControllers([mainVC, bookmarksNav, addRecipeNav, notificationsNav, profileNav], animated: false)
        
        guard let items = self.tabBar.items else { return }
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "bookmark.fill")
        items[2].tag = 2
        items[3].image = UIImage(systemName: "bell.fill")
        items[4].image = UIImage(systemName: "person.crop.circle")
    }
    
    private func setupTabBar() {
        setupCustomShape()
        tabBar.tintColor = UIColor(hex: "#129575FF")
        
    }
    
    private func setupButton() {
        self.tabBar.addSubview(buttonMiddle)
    }
    
    private func setupCustomShape() {
        let path: UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 1
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        self.tabBar.layer.insertSublayer(shape, at: 0)
    }
    
    private func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + 20
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth / 2) - Int(holeWidth / 2)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole, y: 0))
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth / 3, y: holeHeight / 2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth / 3) / 8) * 6, y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth / 3) / 8) * 8, y: holeHeight / 2))
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2 * holeWidth) / 3, y: holeHeight / 2), controlPoint1: CGPoint(x: leftXUntilHole + holeWidth / 3 + holeWidth / 3 / 3 * 2 / 5, y: holeHeight / 2 * 6 / 4), controlPoint2: CGPoint(x: leftXUntilHole + holeWidth / 3 + holeWidth / 3 / 3 * 2 + holeWidth / 3 / 3 * 3 / 5, y: holeHeight / 2 * 6 / 4))
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + 2 * holeWidth / 3, y: holeHeight / 2), controlPoint2: CGPoint(x: leftXUntilHole + 2 * holeWidth / 3 + holeWidth / 3 * 2 / 8, y: 0))
        
        path.addLine(to: CGPoint(x: frameWidth, y: 0))
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight + 20))
        path.addLine(to: CGPoint(x: 0, y: frameHeight + 20))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        path.close()
        return path
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 2 {
            print("middleItemTapped")
        }
    }

}
