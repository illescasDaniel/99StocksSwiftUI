//
//  Asset.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

public protocol AssetProtocol: View {
	init(_ name: String, bundle: Bundle?)
}
extension Image: AssetProtocol {}
extension Color: AssetProtocol {}

@propertyWrapper
struct Asset<AssetType: AssetProtocol> {
	
	let name: String
	let bundle: Bundle?
	
	init(_ name: String, bundle: Bundle? = nil) {
		self.name = "\(AssetType.self)s/\(name)" 
		self.bundle = bundle
	}
	
	var value: AssetType {
		return AssetType(self.name, bundle: self.bundle)
	}
	
}
