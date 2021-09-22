# Ch16. Size Class and Tab Bar

## Tab Bar

- TabView를 사용하여 하단에 TabBar를 추가할 수 있습니다.
- TabView 하위에 tabItem을 추가하여 각 탭을 추가할 수 있으며, Image와 Text를 이용하여 각 탭의 아이콘, 타이틀을 설정할 수 있습니다.

```swift
struct TabBar: View {
    var body: some View {
      TabView {
        NavigationView{
          CoursesView()
        }
        .tabItem {
          Image(systemName: "book.closed")
          Text("Courses")
        }

        NavigationView {
          CourseList()
        }
        .tabItem {
          Image(systemName: "list.bullet.rectangle")
            Text("Tutorials")
        }

        NavigationView {
          CourseList()
        }
        .tabItem {
          Image(systemName: "tv")
          Text("LiveStreams")
        }

        NavigationView {
          CourseList()
        }
        .tabItem {
          Image(systemName: "mail.stack")
          Text("Certificates")
        }

        NavigationView {
          CourseList()
        }
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
        }
      }
    }
}
```

<img width="300" alt="스크린샷 2021-09-19 오후 8 34 01" src="https://user-images.githubusercontent.com/59811450/133927517-1e835c19-683c-4693-9008-ee098ed1563a.png">

- 이후 네비게이션의 기초가 되는 contentView에 환경 변수를 추가하고, 해당 환경 변수가 .compact일 경우에는 TabBar가 보여지도록 코드를 추가합니다.
<img width="396" alt="스크린샷 2021-09-19 오후 9 27 11" src="https://user-images.githubusercontent.com/59811450/133927537-b501d9ae-1379-4de3-b06a-e125141ede6b.png">

![ezgif com-gif-maker](https://user-images.githubusercontent.com/59811450/133927642-02cc75a2-6c14-4a52-b02b-230f70877361.gif)

 
    
   

