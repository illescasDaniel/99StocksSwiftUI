//
//  CompaniesListView.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

struct CompaniesListItemView : View {
	
	let company: CompanyEntry
	
	let stockState: Companies.CompanyStockState
	
	/*company.stockName.companyIcon
	.resizable()
	.aspectRatio(contentMode: .fit)
	.frame(width: 50, height: 50)
	.clipShape(Circle())
	.shadow(radius: 1)*/
    var body: some View {
		HStack(alignment: .center, spacing: 16) {
			VStack(alignment: .leading, spacing: 8) {
				Text(company.name)
					.font(.headline)
				Text(company.stockName)
					.font(.footnote)
			}
			Spacer()
			HStack {
				Image(systemName: self.stockState.directionImageName)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 10, height: 10)
					.foregroundColor(self.stockState.color)
				Text(company.sharePrice.currencyFormatted)
					.font(.system(.headline, design: .monospaced))
					.color(self.stockState.color)
			}
		}
		.padding(.vertical, 8)
    }
}

#if DEBUG
struct CompaniesListItemView_Previews : PreviewProvider {
    static var previews: some View {
        CompaniesListItemView(company: CompanyEntry(id: 0, name: "Apple", stockName: "AMZN", sharePrice: 1000.5),
							  stockState: .neutral)
    }
}
#endif
