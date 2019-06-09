//
//  SceneRouter.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import SwiftUI

/// We will use routers for the app and all the modules, to easily instantiate the views
/// and/or provide multiple different values (like a mock view with mock data)
struct SceneRouter {
	static var initialView: some View {
		Company.Router.ItemList.instance
	}
}
