import Foundation

protocol CustomViewDelegate {
    func setupViews()
    func setupConstraints()
    func setupExtraConfigurations()
    func setup()
}

extension CustomViewDelegate {
    func setup() {
        setupViews()
        setupConstraints()
        setupExtraConfigurations()
    }
}
