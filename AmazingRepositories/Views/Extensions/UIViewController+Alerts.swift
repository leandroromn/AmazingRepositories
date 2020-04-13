import UIKit

extension UIViewController {
    func displayLoadingAlert() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: nil, message: .pleaseWait, preferredStyle: .alert)
            alert.view.addSubview(LoadingActivityIndicator())
            self?.present(alert, animated: true)
        }
    }
    
    func displayErrorAlert(errorMessage: String, action: EmptyClosure?) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            let alert = UIAlertController(title: .errorTitle, message: "\(String.errorDescription)\n\n\(errorMessage)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: .tryAgain, style: .default) { _ in
                action?()
            })
            alert.addAction(UIAlertAction(title: .cancel, style: .cancel))
            self?.present(alert, animated: true)
        }
    }
}
