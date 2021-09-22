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
  @State var showModal = false

  #if os(iOS)
  var cornerRadius: CGFloat = 10
  #else
  var cornerRadius: CGFloat = 0
  #endif

  var body: some View {
    #if os(iOS)
    content
      .edgesIgnoringSafeArea(.all)
    #else
    content
    #endif
  }

  var content: some View {
    VStack {
      ScrollView {
        // 큰 뷰
        CourseItem(course: course, cornerRadius: 0)
          .matchedGeometryEffect(id: course.id, in: nameSpace)
          .frame(height: 300)

        VStack {
          ForEach(courseSections) { item in
            CourseRow(item: item)
              .sheet(isPresented: $showModal, onDismiss: onDismiss) {
                CourseSectionDetail()
              }
              .onTapGesture {
                showModal = true
              }
            Divider()
          }
        }
        .padding()
      }
    }
    .background(Color("Background 1"))
    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    .matchedGeometryEffect(id: "container\(course.id)", in: nameSpace)
  }

  func onDismiss() {
    print("dismissed, showModal: ", showModal)
  }
}

struct CourseDetail_Previews: PreviewProvider {
  @Namespace static var nameSpace

    static var previews: some View {
        CourseDetail(nameSpace: nameSpace)
    }
}
