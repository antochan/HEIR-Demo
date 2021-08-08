//
//  ComponentCollectionViewCell.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 2/6/21.
//

import UIKit

class ComponentCollectionViewCell<T: Component & Reusable & UIView>: UICollectionViewCell {
    public let component = T(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        configureSubviews()
        configureLayout()
        isSkeletonable = true
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
    
    override func prepareForReuse() {
        component.prepareForReuse()
        super.prepareForReuse()
    }
}

extension ComponentCollectionViewCell {
    
    public struct ViewModel {
        public var componentViewModel: T.ViewModel
        
        public init(componentViewModel: T.ViewModel) {
            self.componentViewModel = componentViewModel
        }
    }
    
    func apply(viewModel: ComponentCollectionViewCell.ViewModel) {
        component.apply(viewModel: viewModel.componentViewModel)
    }
    
}
