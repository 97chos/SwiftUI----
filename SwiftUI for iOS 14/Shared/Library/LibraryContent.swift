//
//  LibraryContent.swift
//  DesignCodCourse (iOS)
//
//  Created by 조상호 on 2021/09/22.
//

import SwiftUI

struct LibraryContent: LibraryContentProvider {

  @LibraryContentBuilder
  var views: [LibraryItem] {
    LibraryItem(
      CloseButton(),
      title: "Close Button View",
      category: .control)
  }

  @LibraryContentBuilder
  func modifiers(base: Image) -> [LibraryItem] {
    LibraryItem(
      base.cardStyle(color: Color.blue, cornerRadius: 22),
      title: "card Style",
      category: .control)
  }
}

extension View {
  func cardStyle(color: Color, cornerRadius: CGFloat) -> some View {
    return self
      .background(color)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
      .shadow(color: color.opacity(0.3), radius: 20, x: 0, y: 10)
  }
}
