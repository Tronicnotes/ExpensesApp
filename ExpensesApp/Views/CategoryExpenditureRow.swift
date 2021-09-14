//
//  CategoryExpenditureRow.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 14/09/21.
//

import SwiftUI

struct CategoryExpenditureRow: View {
    private let categoryAvatarSize: CGFloat = 48

    let expediture: CategoryExpenditure

    var body: some View {
        HStack {
            categoryAvatar
            detailsView
            Spacer()
            percentageView
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        .background(Color(.systemGray5))
        .cornerRadius(8)
    }
}

private extension CategoryExpenditureRow {
    var categoryAvatar: some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundColor(expediture.category.color)
            Image(assetIdentifier: expediture.category.imageAsset)
                .resizable()
                .scaledToFit()
                .padding(8)
        }
        .frame(width: categoryAvatarSize, height: categoryAvatarSize)
    }

    var detailsView: some View {
        VStack(alignment: .leading) {
            Text(expediture.category.label)
                .font(.body)
            Text(expediture.totalAmountLabel)
                .font(.title3)
        }
    }

    var percentageView: some View {
        Text(expediture.percentageLabel)
            .font(.title2)
            .bold()
            .foregroundColor(expediture.category.color)
    }
}

struct CategoryExpenditureRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryExpenditureRow(expediture: CategoryExpenditure(category: .shopping, totalAmount: 450, percentageOfBudget: 30))
    }
}
