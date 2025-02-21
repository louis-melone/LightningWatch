//
//  LoadableView.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/21/25.
//

import SwiftUI

/// Protocol for any view that loads content via a network request.
/// Handles spinner view and error views given a conent view for a successfully loaded state
protocol LoadableView {
    var loadableViewState: LoadableViewState { get }
    var retryButtonAction: () async -> Void { get }
    associatedtype LoadedStateView: View
    var contentView: LoadedStateView { get }
}

extension LoadableView {
    @ViewBuilder
    var mainView: some View {
        switch loadableViewState {
        case .loading:
            ProgressView()
        case .loaded:
            contentView
        case let .error(error):
            errorStateView(for: error)
        }
    }
    
    @ViewBuilder
    func errorStateView(for error: LoaderError) -> some View {
        switch error {
        case .invalidUrl, .resourceNotFound, .unknown, .timeout, .serverError:
            ErrorView(
                headline: "Content Unavailable",
                description: "Please try again",
                retryButtonAction: retryButtonAction
            )
        case .noInternet:
            ErrorView(
                headline:  "No Internet Connection",
                description: "Please connect to the internet and try again",
                retryButtonAction: retryButtonAction
            )

        }
    }
}


