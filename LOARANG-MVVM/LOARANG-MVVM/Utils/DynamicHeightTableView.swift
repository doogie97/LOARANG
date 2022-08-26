//
//  DynamicHeightTableView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/26.
//

import UIKit

final class DynamicHeightTableView: UITableView {
  override var intrinsicContentSize: CGSize {
    return self.contentSize
  }

  override var contentSize: CGSize {
    didSet {
        self.invalidateIntrinsicContentSize()
    }
  }
}
