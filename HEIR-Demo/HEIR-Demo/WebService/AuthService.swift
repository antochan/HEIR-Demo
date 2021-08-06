//
//  AuthService.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/6/21.
//

import Firebase

final class AuthService {
    typealias authenticationCompletion = (_ result: Result<AuthDataResult?, Error>) -> Void
    
    func authenticate(with email: String, password: String, completion: @escaping authenticationCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            else {
                completion(.success(authResult))
            }
        }
    }
}

