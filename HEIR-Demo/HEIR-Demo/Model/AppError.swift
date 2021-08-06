//
//  AppError.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/6/21.
//

import Foundation

enum AppError {
    case network(type: Enums.NetworkError)
    case file(type: Enums.FileError)
    case custom(errorDescription: String?)

    class Enums { }
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .network(let type): return type.localizedDescription
            case .file(let type): return type.localizedDescription
            case .custom(let errorDescription): return errorDescription
        }
    }
}

// MARK: - Network Errors

extension AppError.Enums {
    enum NetworkError {
        case parsing
        case notFound
        case custom(errorCode: Int?, errorDescription: String?)
    }
}

extension AppError.Enums.NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .parsing: return "Could not parse properly. Please try again later."
            case .notFound: return "Data was not found. Please try again later."
            case .custom(_, let errorDescription): return errorDescription
        }
    }

    var errorCode: Int? {
        switch self {
            case .parsing: return nil
            case .notFound: return 404
            case .custom(let errorCode, _): return errorCode
        }
    }
}

// MARK: - FIle Errors

extension AppError.Enums {
    enum FileError {
        case read(path: String)
        case write(path: String, value: Any)
        case custom(errorDescription: String?)
    }
}

extension AppError.Enums.FileError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .read(let path): return "Could not read file from \"\(path)\""
            case .write(let path, let value): return "Could not write value \"\(value)\" file from \"\(path)\""
            case .custom(let errorDescription): return errorDescription
        }
    }
}
