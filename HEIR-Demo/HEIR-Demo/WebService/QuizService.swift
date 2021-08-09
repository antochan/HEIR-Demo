//
//  QuizService.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/6/21.
//

import Firebase
import CodableFirebase

final class QuizService {
    typealias getQuizzesCompletion = (_ result: Result<[Quiz], AppError>) -> Void
    typealias getQuizCompletion = (_ result: Result<[Question], AppError>) -> Void
    typealias uploadQuizCompletion = (_ result: Result<Bool, AppError>) -> Void
    typealias deleteQuizCompletion = (_ result: Result<Bool, AppError>) -> Void
    typealias uploadQuizSubmissionCompletion = (_ result: Result<Bool, AppError>) -> Void
    
    func getQuizzes(athleteId: String, completion: @escaping getQuizzesCompletion) {
        CollectionReference.toLocation(.quiz)
            .document(athleteId)
            .collection("quizzes")
            .order(by: "launchTime", descending: false)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(.network(type: .custom(errorCode: error.code,
                                                               errorDescription: error.localizedDescription))))
                }
                
                var quizzes: [Quiz] = []
                for document in snapshot?.documents ?? [] {
                    let quiz: Quiz
                    do {
                        try quiz = FirestoreDecoder().decode(Quiz.self, from: document.data())
                        quizzes.append(quiz)
                    } catch let decodeError {
                        completion(.failure(.file(type: .custom(errorDescription: decodeError.localizedDescription))))
                    }
                }
                
                completion(.success(quizzes))
            }
    }
    
    func getQuizQuestions(athleteId: String, quiz: Quiz, completion: @escaping getQuizCompletion) {
        CollectionReference.toLocation(.quiz)
            .document(athleteId)
            .collection("quizzes")
            .document(quiz.id)
            .collection("quizContent")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(.network(type: .custom(errorCode: error.code,
                                                               errorDescription: error.localizedDescription))))
                }
                
                var questions: [Question] = []
                for document in snapshot?.documents ?? [] {
                    let question: Question
                    do {
                        try question = FirestoreDecoder().decode(Question.self, from: document.data())
                        questions.append(question)
                    } catch let decodeError {
                        completion(.failure(.file(type: .custom(errorDescription: decodeError.localizedDescription))))
                    }
                }
                
                completion(.success(questions))
            }
    }
    
    func uploadQuiz(athleteId: String, quiz: Quiz, questions: [Question], completion: @escaping uploadQuizCompletion) {
        let quizDetailsRef = CollectionReference.toLocation(.quiz)
            .document(athleteId)
            .collection("quizzes")
            .document(quiz.id)
        
        let quizContentRef = CollectionReference.toLocation(.quiz)
            .document(athleteId)
            .collection("quizzes")
            .document(quiz.id)
            .collection("quizContent")
        
        let batch = Firestore.firestore().batch()
        
        guard let quizDict = quiz.dict else {
            completion(.failure(.custom(errorDescription: "Unable to encode `Quiz`")))
            return
        }
        batch.setData(quizDict, forDocument: quizDetailsRef)
        
        questions.forEach {
            guard let questionDict = $0.dict else {
                completion(.failure(.custom(errorDescription: "Unable to encode `Question`")))
                return
            }
            batch.setData(questionDict, forDocument: quizContentRef.document($0.id))
        }
        
        batch.commit() { error in
            if let error = error {
                completion(.failure(.network(type: .custom(errorCode: error.code,
                                                           errorDescription: error.localizedDescription))
                ))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func deleteQuiz(athleteId: String, quizId: String, completion: @escaping uploadQuizCompletion) {
        CollectionReference.toLocation(.quiz)
            .document(athleteId)
            .collection("quizzes")
            .document(quizId)
            .delete { error in
                if let error = error {
                    completion(.failure(.network(type: .custom(errorCode: error.code,
                                                               errorDescription: error.localizedDescription))))
                } else {
                    completion(.success(true))
                }
            }
    }
    
    func makeSubmission(athleteId: String, quizId: String, fanId: String, submission: Submission, quizSelections: [QuizSelection], completion: @escaping uploadQuizSubmissionCompletion) {
        let quizFanSubmissionRef = CollectionReference.toLocation(.quiz)
            .document(athleteId)
            .collection("quizzes")
            .document(quizId)
            .collection("submissions")
            .document(fanId)
        
        let quizFanQuizSelectionRef = CollectionReference.toLocation(.quiz)
            .document(athleteId)
            .collection("quizzes")
            .document(quizId)
            .collection("submissions")
            .document(fanId)
            .collection("selections")
        
        let batch = Firestore.firestore().batch()
        
        guard let submissionDict = submission.dict else {
            completion(.failure(.custom(errorDescription: "Unable to encode `Submission`")))
            return
        }
        batch.setData(submissionDict, forDocument: quizFanSubmissionRef)
        
        quizSelections.forEach {
            guard let quizSelectionDict = $0.dict else {
                completion(.failure(.custom(errorDescription: "Unable to encode `Question`")))
                return
            }
            batch.setData(quizSelectionDict, forDocument: quizFanQuizSelectionRef.document($0.id))
        }
        
        batch.commit() { error in
            if let error = error {
                completion(.failure(.network(type: .custom(errorCode: error.code,
                                                           errorDescription: error.localizedDescription))
                ))
            } else {
                completion(.success(true))
            }
        }
    }
}
