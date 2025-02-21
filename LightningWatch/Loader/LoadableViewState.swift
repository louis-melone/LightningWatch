//
//  LoadableViewState.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation

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
