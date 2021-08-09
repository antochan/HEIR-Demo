//
//  QuizzesCarouselComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/8/21.
//

import UIKit
import SkeletonView

protocol QuizzesCarouselComponentDelegate: AnyObject {
    func quizSelected(quiz: Quiz)
    func quizDelete(quiz: Quiz)
}

final class QuizzesCarouselComponent: UIView, Component, Reusable {
    struct ViewModel {
        var quizzes: [Quiz]
        var isAthletePortal: Bool
        
        init(quizzes: [Quiz], isAthletePortal: Bool) {
            self.quizzes = quizzes
            self.isAthletePortal = isAthletePortal
        }
        
        static let defaultViewModel = ViewModel(quizzes: [],
                                                isAthletePortal: false)
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
        collectionView.isScrollEnabled = false
        collectionView.isSkeletonable = true
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
        isSkeletonable = true
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
        let cellVM = ComponentCollectionViewCell<QuizOverviewComponent>.ViewModel(componentViewModel: QuizOverviewComponent.ViewModel(canDelete: canDelete(quiz: viewModel.quizzes[indexPath.row],
                                                                                                                                                           isAthetePortal: viewModel.isAthletePortal),
                                                                                                                                      quiz: viewModel.quizzes[indexPath.row]))
        cell.component.actions = { [weak self] action in
            switch action {
            case .quizSelected(let quiz):
                self?.delegate?.quizSelected(quiz: quiz)
            case .delete(let quiz):
                self?.delegate?.quizDelete(quiz: quiz)
            }
        }
        cell.apply(viewModel: cellVM)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 275, height: 125)
    }
}

func canDelete(quiz: Quiz, isAthetePortal: Bool) -> Bool {
    // If we are in between the launch and end
    if Date().timeIntervalSince1970 >= quiz.launchTime && Date().timeIntervalSince1970 <= quiz.endTime {
        return false
    }
    // We're past the launch date
    else if Date().timeIntervalSince1970 > quiz.endTime {
        return false
    }
    // We are waiting for launch
    else {
        return isAthetePortal
    }
}
