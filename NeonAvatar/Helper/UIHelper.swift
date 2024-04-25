//
//  UIHelper.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 4.04.2024.
//

import UIKit

enum UIHelper {
    static func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
    let width = CGFloat.deviceWidth
    let padding: CGFloat = 20
    let minimumItemSpacing: CGFloat = 20
    let avaibleWidth = width - (2 * padding) - minimumItemSpacing
    let itemWidth = avaibleWidth / 2
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = 30
    flowLayout.sectionInset = UIEdgeInsets(top: 70, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    return flowLayout
  }
}
