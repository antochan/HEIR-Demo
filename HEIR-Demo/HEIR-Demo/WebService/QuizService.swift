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
}
