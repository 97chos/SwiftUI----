# Ch14. Passing Namespace

## Matched Container
- 상위 클래스에서 사용하던 namespace를 하위 클래스에 전달하여 데이터를 나타낼 수 있습니다.
- 기존 정적인 데이터가 아닌, 빌드 후 동적인 데이터를 이용하여 view를 구성하는 방법입니다.

- 기존 CourseView에서 사용하던 detailView를 CourseDetail이란 클래스로 분리하여 생성하였습니다.
    - 기존 코드
    ```swift
    if selectedItem != nil {
      ZStack(alignment: .topTrailing) {
        VStack {
          ScrollView {
            // 큰 뷰
            CourseItem(course: selectedItem!)
              .matchedGeometryEffect(id: selectedItem!.id, in: nameSpace)
              .frame(height: 300)
              .transition(.opacity)


            VStack {
              ForEach(0 ..< 20) { item in
                CourseRow()
              }
            }
            .padding()
          }
        }
        .background(Color("Background 1"))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .matchedGeometryEffect(id: "container\(selectedItem!.id)", in: nameSpace)
        // safeArea 무시
        .edgesIgnoringSafeArea(.all)

        ...
      }
    ```
      
    - 변경 후
    ```swift
    if selectedItem != nil {
      ZStack(alignment: .topTrailing) {
        CourseDetail(course: selectedItem!, nameSpace: namespace)

        ...
      }
      .zIndex(2)
    }
    ```

    - Course 타입의 course 변수와 namespace.id 타입의 nameSpace 변수를 생성하여 initialize 시 값을 받아올 수 있도록 구현
    ```swift
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
              // courseSections라는 [CourseSection] 타입의 배열을 정의, 각 CourseSection Element들을 CourseRow의 인자값으로 전달한다. 
                ForEach(courseSections) { item in
                  CourseRow(item: item)
                  // 구분선 추가
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
    ```
    
    - **CourseSection**
    ```swift
    struct CourseSection: Identifiable, Hashable {
        var id = UUID()
        var title: String
        var subtitle: String
        var logo: String
        var color: Color
    }
    ```

  - Preview에서도 변경된 view를 확인할 수 있도록 임의의 namespace를 생성하여 init 처리
  ```swift
  struct CourseDetail_Previews: PreviewProvider {
    @Namespace static var nameSpace

      static var previews: some View {
          CourseDetail(nameSpace: nameSpace)
      }
  }
  ```
  
- CourseRow 또한 CourseSection을 담을 변수를 생성하여, 고정된 값을 보여주는 것이 아닌 해당 데이터 값에 따라 view의 내용이 변경되도록 수정
```swift

struct CourseRow: View {
  var item: CourseSection = courseSections[0]

    var body: some View {
      HStack(alignment: .top) {
        Image(item.logo)
          .renderingMode(.original)
          .frame(width: 48.0, height: 48.0)
          .imageScale(.medium)
          .background(item.color)
          .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        VStack(alignment: .leading, spacing: 4.0) {
          Text(item.title)
            .font(.subheadline)
          Text(item.subtitle)
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        Spacer()
      }
    }
}
```

![ezgif com-gif-maker (1)](https://user-images.githubusercontent.com/59811450/131068325-e92a8eac-c02a-4559-a2c4-8d70b0436aab.gif)

