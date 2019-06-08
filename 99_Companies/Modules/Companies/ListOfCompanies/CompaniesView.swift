//
//  ContentView.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI
import Combine

struct CompaniesView : View {
	
	@EnvironmentObject
	var companies: Companies
	
	@State var searchText: String = ""

    var body: some View {
		NavigationView {
			VStack(spacing: 16) {
				TextField($searchText, placeholder: Text(L10n.Sections.Companies.TextField.search),
						  onCommit: onTextFieldCommit)
					.frame(height: 40)
					.padding(.horizontal, 16)
					.border(Color.gray, cornerRadius: 12)
					.padding(.horizontal, 12)
				if (companies.data.isEmpty) {
					Spacer()
					ActivityIndicatorView(style: .large)
						.setAnimating(true)
					Spacer()
				} else {
					List(companies.data) { company in
						NavigationButton(destination: CompanyDetailRouter.instance(companyId: company.id)) {
							CompaniesListItemView(company: company,
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
						Image(systemName: "arrow.counterclockwise.circle.fill")
							//.frame(width: 30, height: 30)
					}
				})
			)
		}
    }
	
	//
	
	func onTextFieldCommit() {
		
	}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        CompaniesViewRouter.mockInstance
    }
}
#endif
