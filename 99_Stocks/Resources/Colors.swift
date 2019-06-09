//
//  Colors.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

enum Colors {
	enum Companies {
		enum Currency {
			@Asset("Companies/\(Self.self)/up")
			static var up: Color
			@Asset("Companies/\(Self.self)/down")
			static var down: Color
			@Asset("Companies/\(Self.self)/neutral")
			static var neutral: Color
		}
	}
}

