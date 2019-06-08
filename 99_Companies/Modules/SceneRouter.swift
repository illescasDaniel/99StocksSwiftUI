//
//  SceneRouter.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import SwiftUI

struct SceneRouter {
	static var initialView: some View {
		CompaniesViewRouter.instance
	}
}
