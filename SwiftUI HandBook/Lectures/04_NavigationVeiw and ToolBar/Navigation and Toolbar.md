# Ch4. NavigationView and Toolbar

## NavigationView
- NavigationView 메소드를 이용하여 Navigation 화면전환을 구현할 수 있습니다.
- Pro Max 이상의 iPhone 가로 모드나 iPad 등 넓은 화면에서는 SideBar 형태로 적용됩니다.
 
```swift
// TutorialView.swift

struct TutorialView: View {
  var body: some View {
    Text("TutorialView")
      .navigationTitle(Text("Style"))
  }
}
```

```swift
// HomeView.swift

      NavigationView {
        List {
          NavigationLink(destination: ContentView()) {
            Label("HomeView", systemImage: "book")
          }
          NavigationLink(destination: TutorialView()) {
            Label("TutorialView", systemImage: "square")
          }
        }
      .navigationTitle("Learn")
      
      // Sidebar 형태 적용시 보여질 기본 View 
      ContentView()
```

- NavigationView의 Title은 .navigationTitle로 설정할 수 있습니다.
- 기본적인 Navigation List는 NavigationLink의 List로 구성되며, NavigationLink의 destination을 통해 목적지 view를 설정할 수 있습니다.

### 일반적인 iPhone 크기
> ![Simulator Screen Recording - iPhone 12 Pro Max - 2021-09-26 at 17 19 54](https://user-images.githubusercontent.com/59811450/134800402-4bfe272c-cf79-4763-b09f-0b647aa89c2a.gif)

### iPhone12 Pro Max 가로모드
> ![Simulator Screen Recording - iPhone 12 Pro Max - 2021-09-26 at 17 20 19](https://user-images.githubusercontent.com/59811450/134800407-9609d891-0399-4311-87bf-dea25785a763.gif)

### iPad 
> ![Simulator Screen Recording - iPad Pro (12 9-inch) (5th generation) - 2021-09-26 at 17 21 12](https://user-images.githubusercontent.com/59811450/134800412-12878b7d-a6c5-4135-86b3-56692b9c5c16.gif)

## Toolbar
- View 상단의 NavigationBar나 하단 Toolbar 버튼을 추가할 수 있습니다.

```swift
// HomeView.swift

    var body: some View {
      NavigationView {
        List {
          ...
        }
        .toolbar() {
          ToolbarItem() {
            Image(systemName: "person")
          }
        }
        .navigationTitle("Learn")

        ContentView()
      }
    }
```
- toolbar() 메소드 이후 클로저 형태로 ToolbarItem을 적용하였습니다.
> <img width="300" alt="스크린샷 2021-09-26 오후 5 29 20" src="https://user-images.githubusercontent.com/59811450/134800423-d0d431c8-c2f0-471f-8cc5-71b7fa5b7b76.png">

- ToolbarItem의 인자값으로 placement를 전달하여 ToolbarItem의 위치를 정의할 수 있으며, 아무런 값도 전달하지 않을 시 기본값으로 .navigationBarTrailing이 설정됩니다.

- 만약 여러 개의 ToolbarItem을 구현하고자 경우 다음과 같이 작성합니다.

```swift
// HomeView.swift

    var body: some View {
      NavigationView {
        List {
          ...
        }
        .toolbar() {
          ToolbarItemGroup(placement: .bottomBar) {
            Image(systemName: "person")
            Spacer()
            HStack {
              Image(systemName: "ellipsis")
              Divider()
              Image(systemName: "trash")
                .frame(width: 32, height: 32)
                .background(Color.blue)
                .mask(Circle())
            }
          }
        }
        .navigationTitle("Learn")

        ContentView()
      }
    }
```
> <img width="300" alt="스크린샷 2021-09-26 오후 5 42 51" src="https://user-images.githubusercontent.com/59811450/134800497-b36a0b27-75e2-4cbc-af57-9b182a4ed855.png">

- ToolbarItem 대신 ToolbarItemGroup을 사용하여 여러 개의 ToolbarItem을 배치하였고, placement로 .bottomBar를 전달하여 하단에 Toolbar가 위치하도록 구현하였습니다.
- ToolbarItem 사이 Spacer를 위치시키면 원하는 위치에 item을 정렬할 수 있습니다.
