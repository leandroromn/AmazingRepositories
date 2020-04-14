import UIKit

class LoadingActivityIndicator: UIActivityIndicatorView {
    init() {
        super.init(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        hidesWhenStopped = true
        style = .medium
        tintColor = .darkGray
        startAnimating()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
