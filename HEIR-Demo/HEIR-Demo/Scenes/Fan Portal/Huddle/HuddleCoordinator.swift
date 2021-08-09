//
//  HuddleCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class HuddleCoordinator: RootCoordinator, Coordinator {
    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let quizService: QuizService
    private let user: User
    private let athleteId: String
    
    lazy var huddleViewModel: HuddleViewModel? = {
        let viewModel = HuddleViewModel(quizService: quizService,
                                        athleteId: athleteId,
                                        user: user)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(controller: UINavigationController, quizService: QuizService, user: User, athleteId: String) {
        self.navigationController = controller
        self.quizService = quizService
        self.user = user
        self.athleteId = athleteId
    }
    
    func start() {
        let huddleViewController = HuddleViewController()
        let huddleNavController = UINavigationController(rootViewController: huddleViewController)
        huddleNavController.setNavigationBarHidden(true, animated: false)
        huddleNavController.isHeroEnabled = true
        huddleViewController.viewModel = huddleViewModel
        huddleNavController.modalPresentationStyle = .fullScreen
        navigationController.present(huddleNavController, animated: true)
        
        addChildCoordinator(self)
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

// MARK: - HuddleViewModelCoordinatorDelegate

extension HuddleCoordinator: HuddleViewModelCoordinatorDelegate {
    
    func launchQuiz(with controller: UINavigationController, quiz: Quiz, questions: [Question]) {
        removeAllChildCoordinatorsWith(type: HuddleCoordinator.self)
        
        let quizCoordinator = QuizCoordinator(controller: controller,
                                              quizService: quizService,
                                              user: user,
                                              athleteId: athleteId,
                                              quiz: quiz,
                                              questions: questions)
        quizCoordinator.start()
    }
    
    func launchQuizResult(with controller: UINavigationController, quiz: Quiz) {
        removeAllChildCoordinatorsWith(type: HuddleCoordinator.self)
        
        let quizResultCoordinator = QuizResultCoordinator(baseController: controller,
                                                    controller: controller.topViewController,
                                                    quizService: quizService,
                                                    user: user,
                                                    athleteId: athleteId,
                                                    quiz: quiz)
        quizResultCoordinator.start()
    }
    
    func close(with controller: UINavigationController) {
        controller.dismiss(animated: true)
    }
}
