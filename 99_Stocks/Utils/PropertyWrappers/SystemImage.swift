//
//  SystemImage.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 09/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

@propertyWrapper
struct SystemImage {
	let name: String
	init(_ name: String) {
		self.name = name
	}
	var wrappedValue: Image {
		return Image(systemName: name)
	}
}
