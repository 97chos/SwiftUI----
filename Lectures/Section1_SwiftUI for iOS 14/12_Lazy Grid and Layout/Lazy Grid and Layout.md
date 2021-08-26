# Ch1. Lazy Grid and Layout

## Lazy Grid
- Lazy Grid를 사용하면 적응형 레이아웃을 만들 수 있습니다.

```swift
  var body: some View {
    ZStack {
      ScrollView {
      // LazyVGrid
        LazyVGrid(columns: [GridItem()], spacing: 0) {
          ForEach(courses) { item in
            CourseItem(course: item)
              .matchedGeometryEffect(id: item.id, in: nameSpace, isSource: !show)
              .frame(height: 250)
              .onTapGesture {
                withAnimation(.spring()) {
                  show.toggle()
                  selectedItem = item
                  isDisable = true
                }
              }
              .disabled(isDisable)
          }
        }
        .frame(maxWidth: .infinity)
      }
```

<img width="300" alt="스크린샷 2021-08-26 오후 12 31 18" src="https://user-images.githubusercontent.com/59811450/130896090-b1c936fe-1f91-43f8-b23a-e7f71733382e.png">

- **GridItem**
  - GridItem의 인스턴스는 LazyVGrid, LazyHGrid에서 각 Columns(HGrid는 rows)의, 레이아웃(간격, 정렬, 사이즈 등)을 설정하는데에 사용됩니다. (VGrid의 경우 columns, HGrid의 경우 rows)

- spacing 값을 변경하여 item 간의 간격을 조정할 수 있습니다.
 ```swift
     LazyVGrid(columns: [GridItem()], spacing: 20) {
      ...
     }
 ```
- LazyVGrid에 padding 값을 주어 양 옆에 여백을 줄 수 있습니다.
 ```swift
  /// LazyVGrid
  .padding(10)
 ```
- LazyVGrid 배열 내에 GridItem의 인스턴스를 추가하여 Coulumn의 수를 변경할 수 있습니다.
 ```swift
     LazyVGrid(columns: [GridItem(),GridItem(),GridItem()], spacing: 20) {
      ...
     }
 ```
> <img width="300" alt="spacing: 20, padding: 10, GridItem 3개" src="https://user-images.githubusercontent.com/59811450/130897184-d13e8aaf-0034-4d4a-8418-e217df3ce34f.png">
> spacing: 20, padding: 10, GridItem 3개

- GridItem에 정렬 속성을 추가할 수 있습니다.
  - ### . adaptive
    -  (LazyVGrid의 경우) minimum 값 이상의 사이즈로 columns마다 가능한 많이 아이템들을 배치하고자 할 때 사용되는 속성입니다.
    -  minimum과 maximum (혹은 둘 중 하나) 사이즈만 설정하면 기기의 스크린 사이즈에 맞춰서 자동적으로 columns의 수가 정해져서 배치되기 때문에, 정확한 columns의 수가 명세되어 있지 않다면 가장 편하게 사용할 수 있습니다.
    ```swift
         LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
          ...
         }
    ```
      <img width="300" alt="스크린샷 2021-08-26 오후 1 02 42" src="https://user-images.githubusercontent.com/59811450/130898670-772c234c-2a97-45c2-bb22-dd9d8f3c9cee.png">
    
  - ### .flexible
    - (LazyVGrid의 경우) minimum 값 이상의 사이즈로 column 수를 조절 하고 싶을 때 사용되는 사이즈 입니다. adaptive와 유사하나, 스크린 사이즈에 맞게 자동으로 조정되는 adaptive와 달리 columns마다 배치되는 아이템 수를 조절할 수 있다는 점에서 다릅니다.

  - ### .fixed
    - (LazyVGrid의 경우) columns 크기를 직접 조절하고 싶을 때 사용하는 속성입니다.

- Array로 GridItem을 생성할 수 있습니다. 
 ```swift
     LazyVGrid(columns: Array(repeating: .init(.adaptive(minimum: 100), spacing: 16),
                                 count: 2), 
                              spacing: 20) {
      ...
     }
 ```
 <img width="300" alt="스크린샷 2021-08-26 오후 5 46 08" src="https://user-images.githubusercontent.com/59811450/130931925-d09b9717-81d3-47f3-8c22-190b65c6e20a.png">
 
 
    
   

