//
//  Colors.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

enum Colors {
	enum Currency {
		@Asset("\(Self.self)/growing")
		static var growing: Color
		@Asset("\(Self.self)/falling")
		static var falling: Color
		@Asset("\(Self.self)/neutral")
		static var neutral: Color
	}
}

