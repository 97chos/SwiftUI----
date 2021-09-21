# Ch19. Library Content and Modifiers

## Library Content Provider

- Library Content Provider를 생성하여 반복되는 뷰를 라이브러리에 추가하므로써, 뷰의 재사용성을 높일 수 있습니다.

```swift
// LibraryContent.swift

struct LibraryContent: LibraryContentProvider {

  @LibraryContentBuilder
  var views: [LibraryItem] {
    LibraryItem(
      CloseButton(),
      title: "Close Button View",
      category: .control)
  }
}
```

- LibraryContentBuilder 태그를 생성하고, [LibraryItem]을 타입으로 갖는 views 내부에 LibraryItem 항목을 생성하면, <pre><code>com + shift + L</code></pre> 키를 눌러서 호출되는 라이브러리 메뉴창에서 title을 검색하여 간단하게 해당 뷰를 삽입할 수 있습니다.

  (이미지)
  
- 카테고리에는 control, effect, layout, other 등의 case가 있으며, 이를 통해 categorizing이 가능합니다.


## Reusable Modifiers

- 재사용할 수 있는 Modifier 메소드를 라이브러리에 등록하여 사용할 수도 있습니다.

```swift
// LibraryContent.swift

  @LibraryContentBuilder
  var views: [LibraryItem] {
    ...
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
```

- View에 대한 extension 메소드로 cardStyle을 정의하고, 해당 메소드로 리턴되는 LibraryItem을 card Style이란 이름으로 라이브러리에 등록한 모습입니다.

(이미지)

- Modifier Library 적용 이전
```swift
//  CourseItem.swift

  var body: some View {
    VStack(alignment: .leading) {
      ...
    }
    .padding(.all)
    .background(course.color)
    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    .shadow(color: course.color.opacity(0.3), radius: 20, x: 0, y: 10)
  }
```

- Modifier Library 적용 이후
```swift
//  CourseItem.swift

  var body: some View {
    VStack(alignment: .leading) {
      ...
    }
    .padding(.all)
    .cardStyle(color: course.color, cornerRadius: cornerRadius)
  }
```
