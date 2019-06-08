//
//  AnySubscription.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import Combine

final class AnySubscription: Subscription {
	
	private let cancellable: AnyCancellable
	
	init(_ cancel: @escaping () -> Void) {
		self.cancellable = AnyCancellable(cancel)
	}
	
	func request(_ demand: Subscribers.Demand) {}
	
	func cancel() {
		cancellable.cancel()
	}
}
