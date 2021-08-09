//
//  QuizQuestionsCarouselComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/8/21.
//

import UIKit
import SkeletonView

protocol QuizQuestionCarouselDelegate: AnyObject {
    func selectedAnswer(question: Question, selectedAnswer: String)
}

final class QuizQuestionsCarouselComponent: UIView, Component, Reusable {
    struct ViewModel {
        var questions: [Question]
        
        init(questions: [Question]) {
            self.questions = questions
        }
        
        static let defaultViewModel = ViewModel(questions: [])
    }
    
    private var viewModel = ViewModel.defaultViewModel {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: QuizQuestionCarouselDelegate?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.isScrollEnabled = false
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
    
    func scrollTo(page: Int) {
        collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
    }
}

//MARK: - Private

private extension QuizQuestionsCarouselComponent {
    func commonInit() {
        backgroundColor = UIColor.clear
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
        collectionView.register(ComponentCollectionViewCell<QuizQuestionComponent>.self, forCellWithReuseIdentifier: "QuizQuestionCell")
    }
}

//MARK: - UICollectionView Delegate & DataSource

extension QuizQuestionsCarouselComponent: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizQuestionCell", for: indexPath) as! ComponentCollectionViewCell<QuizQuestionComponent>
        let cellVM = ComponentCollectionViewCell<QuizQuestionComponent>.ViewModel(componentViewModel: QuizQuestionComponent.ViewModel(isInCreation: false,
                                                                                                                                      question: viewModel.questions[indexPath.row],
                                                                                                                                      totalQuestionCount: viewModel.questions.count,
                                                                                                                                      currentQuestionIndex: indexPath.row))
        cell.component.actions = { [weak self] action in
            switch action {
            case .deleteTapped:
                /// Not applicable since we cannot delete stuff right now
                break
            case .selectedOption((let question, let option)):
                self?.delegate?.selectedAnswer(question: question,
                                               selectedAnswer: option)
            }
        }
        cell.apply(viewModel: cellVM)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
