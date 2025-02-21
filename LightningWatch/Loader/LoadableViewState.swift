//
//  LoadableViewState.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation

/// Choosing to limit error cases to 404 not found, no internet connection, timeout (slow connection) or server error
/// other errors like unauthorized can be implmented if the app ever gets auth, for example
enum LoaderError: Error {
    case invalidUrl
    case noInternet
    case resourceNotFound
    case timeout
    case serverError(Int)
    case unknown(String)
}

enum LoadableViewState {
    case loading
    case loaded
    case error(LoaderError)
}
