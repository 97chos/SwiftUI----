//
//  CourseDetail.swift
//  DesignCodCourse
//
//  Created by 조상호 on 2021/08/27.
//

import SwiftUI

struct CourseDetail: View {
  var course: Course = courses[0]
  var nameSpace: Namespace.ID

    var body: some View {
      VStack {
        ScrollView {
          // 큰 뷰
          CourseItem(course: course)
            .matchedGeometryEffect(id: course.id, in: nameSpace)
            .frame(height: 300)

          VStack {
            ForEach(courseSections) { item in
              CourseRow(item: item)
              Divider()
            }
          }
          .padding()
        }
      }
      .background(Color("Background 1"))
      .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
      .matchedGeometryEffect(id: "container\(course.id)", in: nameSpace)
      // safeArea 무시
      .edgesIgnoringSafeArea(.all)
    }
}

struct CourseDetail_Previews: PreviewProvider {
  @Namespace static var nameSpace

    static var previews: some View {
        CourseDetail(nameSpace: nameSpace)
    }
}
