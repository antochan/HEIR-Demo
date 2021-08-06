//
//  UserService.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/6/21.
//

import Firebase
import CodableFirebase

final class UserService {
    typealias getUserCompletion = (_ result: Result<User?, AppError>) -> Void
    
    func getUser(uid: String, completion: @escaping getUserCompletion) {
        CollectionReference.toLocation(.users).document(uid).getDocument { (document, error) in
            if let error = error {
                completion(.failure(.network(type: .custom(errorCode: error.code,
                                                           errorDescription: error.localizedDescription))
                ))
            }
            
            if let document = document, let data = document.data(), document.exists {
                do {
                    let user = try FirebaseDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch let error {
                    completion(.failure(.network(type: .custom(errorCode: error.code,
                                                               errorDescription: error.localizedDescription))
                    ))
                }
            }
            else {
                completion(.failure(.network(type: .notFound)))
            }
        }
    }
}
