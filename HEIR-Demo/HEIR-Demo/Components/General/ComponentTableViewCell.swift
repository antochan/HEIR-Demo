//
//  ComponentTableViewCell.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 2/6/21.
//

import UIKit

class ComponentTableViewCell<T: Component & Reusable & UIView>: UITableViewCell {
    
    public let component = T(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        component.prepareForReuse()
    }
}

private extension ComponentTableViewCell {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        contentView.addSubview(component)
    }
    
    func configureLayout() {
        component.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            component.topAnchor.constraint(equalTo: contentView.topAnchor),
            component.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            component.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            component.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension ComponentTableViewCell {
    
    public struct ViewModel {
        public var componentViewModel: T.ViewModel
        
        public init(componentViewModel: T.ViewModel) {
            self.componentViewModel = componentViewModel
        }
    }
    
    func apply(viewModel: ComponentTableViewCell.ViewModel) {
        component.apply(viewModel: viewModel.componentViewModel)
    }
    
}
