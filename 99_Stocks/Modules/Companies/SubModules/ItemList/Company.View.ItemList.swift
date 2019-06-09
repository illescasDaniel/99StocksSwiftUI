//
//  ContentView.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

extension Company.View {
	
	struct ItemList : View {
		
		@EnvironmentObject
		var companies: Company.ViewModel.ItemList
		
		var body: some View {
			NavigationView {
				VStack(spacing: 16) {
					TextField($companies.searchText, placeholder: Text(L10n.Sections.Companies.TextField.search),
							  onCommit: onTextFieldCommit)
						.frame(height: 40)
						.padding(.horizontal, 16)
						.border(Color.gray, cornerRadius: 12)
						.padding(.horizontal, 12)
					if (companies.realData.isEmpty) {
						Spacer()
						if companies.searchText.isEmpty {
							ActivityIndicatorView(style: .large)
								.setAnimating(true)
						} else {
							Text(L10n.Sections.Companies.Label.emptyResults)
						}
						Spacer()
					} else {
						List(companies.realData) { (company: Company.Model.ItemList) in
							NavigationButton(destination: Company.Router.DetailItem.instance(companyId: company.id)) {
								Company.View.ListItem(company: company,
													  stockState: self.companies.stockState(for: company.id))
							}
						}
					}
				}
				.navigationBarTitle(Text(L10n.Sections.Companies.Label.title))
				.navigationBarItems(trailing:
					Button(action: {
						self.companies.reload()
					}, label: {
						HStack {
							Text(L10n.Sections.Companies.Button.reload)
							Images.System.reloadIcon
						}
					})
				)
			}
		}
		
		//
		
		func onTextFieldCommit() {
			#if canImport(UIKit)
			UIApplication.shared.keyWindow?.endEditing(true)
			#endif
		}
	}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
	static var previews: some View {
		Company.Router.ItemList.mockInstance
	}
}
#endif
