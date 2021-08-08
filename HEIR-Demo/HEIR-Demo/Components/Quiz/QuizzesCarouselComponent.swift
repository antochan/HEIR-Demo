//
//  QuizzesCarouselComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/8/21.
//

import UIKit

protocol QuizzesCarouselComponentDelegate: AnyObject {
    func quizSelected(quiz: Quiz)
}

final class QuizzesCarouselComponent: UIView, Component, Reusable {
    struct ViewModel {
        var quizzes: [Quiz]
        
        init(quizzes: [Quiz]) {
            self.quizzes = quizzes
        }
        
        static let defaultViewModel = ViewModel(quizzes: [])
    }
    
    private var viewModel = ViewModel.defaultViewModel {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: QuizzesCarouselComponentDelegate?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Spacing.eight
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Color.Primary.White
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Spacing.twelve, bottom: 0, right: Spacing.twelve)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func apply(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func prepareForReuse() {
        // no-op
    }
}

//MARK: - Private

private extension QuizzesCarouselComponent {
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
        configureCollectionView()
    }
    
    func configureSubviews() {
        addSubviews(collectionView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ComponentCollectionViewCell<QuizOverviewComponent>.self, forCellWithReuseIdentifier: "QuizOverviewCell")
    }
}

//MARK: - UICollectionView Delegate & DataSource

extension QuizzesCarouselComponent: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizOverviewCell", for: indexPath) as! ComponentCollectionViewCell<QuizOverviewComponent>
        let cellVM = ComponentCollectionViewCell<QuizOverviewComponent>.ViewModel(componentViewModel: QuizOverviewComponent.ViewModel(quiz: viewModel.quizzes[indexPath.row]))
        cell.component.actions = { [weak self] action in
            switch action {
            case .quizSelected(let quiz):
                self?.delegate?.quizSelected(quiz: quiz)
            }
        }
        cell.apply(viewModel: cellVM)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 275, height: 125)
    }
}
