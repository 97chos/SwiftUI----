//
//  CourseList.swift
//  DesignCodCourse
//
//  Created by 조상호 on 2021/08/25.
//

import SwiftUI

struct CourseList: View {
  @ViewBuilder
  var body: some View {
    #if os(iOS)
    content
      .listStyle(InsetGroupedListStyle())
    #else
    content
      .frame(minWidth: 800, minHeight: 600)
    #endif
  }
  var content: some View {
    List(0 ..< 20) { item in
      CourseRow()
    }
    .navigationTitle("Courses")
  }
}

struct CourseList_Previews: PreviewProvider {
  static var previews: some View {
    CourseList()
  }
}

