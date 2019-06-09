//
//  ActivityIndicatorView.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

final class ActivityIndicatorView: UIViewRepresentable {
	
	typealias UIViewType = UIActivityIndicatorView
	
	var view: UIActivityIndicatorView
	private var _isAnimating: Bool = false
	
	init(style: UIActivityIndicatorView.Style = .medium) {
		self.view = UIActivityIndicatorView(style: style)
		self.view.hidesWhenStopped = true
	}
	
	// MARK: - Public methods
	
	func setAnimating(_ isAnimating: Bool) -> Self {
		_isAnimating = isAnimating
		return self
	}
	
	// MARK: - UIViewRepresentable
	
	func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
		self.view.frame = self.defaultFrame
		return self.view
	}
	
	func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
		uiView.layoutIfNeeded()
		uiView.color = context.environment.colorScheme == .dark ? .lightGray : .gray
		if !_isAnimating {
			uiView.stopAnimating()
			uiView.isHidden = true
			uiView.frame = .zero
		} else {
			uiView.startAnimating()
			uiView.isHidden = false
			uiView.frame = self.defaultFrame
		}
	}
	
	// MARK: - Convenience
	
	private var defaultFrame: CGRect { .init(x: 0, y: 0, width: 50, height: 50) }
}
