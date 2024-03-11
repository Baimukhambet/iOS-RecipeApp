import UIKit

extension UIApplication {
    static let screenSize = (UIApplication.shared.connectedScenes.first as! UIWindowScene).screen.bounds
}
