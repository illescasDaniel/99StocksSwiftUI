//
//  Images.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

enum Images {
	
	enum Companies {
		
		@Asset("\(Self.self)/amazon")
		static var amazon: Image
		
		@Asset("\(Self.self)/alibaba")
		static var alibaba: Image
		
		@Asset("\(Self.self)/alphabet")
		static var alphabet: Image
		
		@Asset("\(Self.self)/apple")
		static var apple: Image
		
		@Asset("\(Self.self)/berkshire")
		static var berkshire: Image
		
		@Asset("\(Self.self)/facebook")
		static var facebook: Image
		
		@Asset("\(Self.self)/johnson")
		static var johnson: Image
		
		@Asset("\(Self.self)/jpmorgan")
		static var jpmorgan: Image
		
		@Asset("\(Self.self)/microsoft")
		static var microsoft: Image
		
		enum SharePriceState {
			
			@SystemImage("equal")
			static var neutral: Image
			
			@SystemImage("arrowtriangle.up.fill")
			static var up: Image
			
			@SystemImage("arrowtriangle.down.fill")
			static var down: Image
		}
	}
	
	enum System {
		@SystemImage("arrow.counterclockwise.circle.fill")
		static var reloadIcon: Image
		
	}

}

