# Ch12. Property Wrapper

## Property Wrapper
- Property Wrapper는 Swift 5.1부터 추가된 기능으로, Annotation을 활용하여 로직이 Wrapping된 property를 사용하는 기능입니다.
- 즉, **프로퍼티 자체에 로직들을 연결할 수 있어 보일러 플레이트 코드와 코드 재사용성을 높여주는데 도움**을 줄 수 있습니다.
- SwiftUI에서 사용하는 `@State, @Binding, @Published, @ObservedObject` 등이 Property Wrapper에 해당됩니다. 


### 정의 및 사용
 ```swift
@propertyWrapper
struct Uppercase {  
  private var value: String = ""
  
  var wrappedValue: String {
    get { self.value }
    set { self.value = newValue.uppercased() }
  }
  
  init(wrappedValue value: String) {
    self.wrappedValue = value
  }
}
```

- 선언한 Uppercase는 value 값을 전달받아 이를 uppercased 처리하여 value에 저장하게 됩니다.
- 위 예제처럼 타입 앞에 `@propetyWrapper`를 붙여 컴파일러에게 **해당 타입은 일반 타입이 아닌 행동을 정의하는 타입**임을 알려주어 사용합니다.

```swift
struct Address {
  @Uppercase var town: String
}

let address = Address(town: "earth")
print(address.town) // EARTH
```

- address 상수에 저장된 Address.town은 Uppercase라는 propertyWrapper를 거쳐 동작합니다.
- 따라서 엄밀히 말하자면 town은 String 형이 아닌, PropertyWrapper의 WrappedValue로 래핑된 값의 성질을 띄게 됩니다.
- init 선언으로 데이터의 할당과 동시에 wrappedValue에 정의된 Set을 거쳐 데이터를 처리한 다음 할당됩니다.

- Uppercase 또한 struct로 만들어졌기 때문에,
```swift
struct Address {
  @Uppercase(wrappedValue: "earth") 
  var town: String
}

let address = Address()
print(address.town) // EARTH
```

- 이런식으로 아예 Uppercase를 선언할 당시부터 value 값을 지정하여 초기화할 수도 있습니다.
- 만약, Uppercase의 init을 지운다면

<img width="421" alt="스크린샷 2022-01-14 오후 11 46 27" src="https://user-images.githubusercontent.com/59811450/149534445-dcd918a8-1acf-467e-adb8-a4d657810738.png">

- 위와 같이 명시적으로 선언된 town의 String 타입이 아닌, Uppercase 타입을 받게 됩니다. 

```swift
struct Person {
  @Uppercase var name: String
}

let person = Person(name: "sam")
print(person.name) // SAM
```

- 같은 로직을 가진 propertyWrapper를 Person이라는 struct에 적용한 모습입니다.
- Address와 Person의 프로퍼티는 같은 로직을 갖고 있지만, 해당 로직을 propertyWrapper에 담아 적용시킴으로써 반복되는 코드의 양을 최소화하였습니다.
- 이처럼 **Property Wrapper는 반복되는 로직을 프로퍼티 자체에 연결하여 코드의 재사용성을 높이는데 도움을 줄 수 있습니다.**

### WWDC 19 예제
  
```swift
class UserManager {
  static var usesTouchID: Bool {
    get { return UserDefaults.standard.bool(forKey: "usesTouchID") }
    set { UserDefaults.standard.set(newValue, forKey: "usesTouchID") }
  }
  static var myEmail: String? {
    get { return UserDefaults.standard.string(forKey: "myEmail") }
    set { UserDefaults.standard.set(newValue, forKey: "myEmail") }
  }
  static var isLoggedIn: Bool {
    get { return UserDefaults.standard.bool(forKey: "isLoggedIn") }
    set { UserDefaults.standard.set(newValue, forKey: "isLoggedIn") }
  }
}
```
- WWDC 19에서 사용한 UserDefaults 관련 예제입니다.
- 각각의 Key와 다른 타입의 value 값을 갖고 있으며, 변수마다 get,set 부분에서 같은 로직이 중복 사용되고 있음을 확인할 수 있습니다.
- 위 코드를 `@propertyWrapper`를 이용하여 개선한다면

```swift
@propertyWrapper
struct UserDefault<T> {
  let key: String
  let defaultValue: T
  
  var wrappedValue: T {
    get { UserDefaults.standard.object(forKey: self.key) as? T ?? self.defaultValue }
    set { UserDefaults.standard.set(newValue, forKey: self.key) }
  }
}

class UserManager {
  @UserDefaults(key: "usesTouchID", defaultValue: false)
  static var usesTouchID: Bool
  
  @UserDefaults(key: "myEmail", defaultValue: nil)
  static var myEmail: String?
  
  @UserDefaults(key: "isLoggedIn", defaultValue: false)
  static var isLoggedIn: Bool
}
```

- 이런식으로 UserDefault의 이니셜라이징을 이용하여 기본 값을 지정 할당하여 개선할 수 있습니다. 


## @State

- 일반적으로 struct는 값 타입이어서, struct 내의 값을 변경할 수 없습니다.
- 이에 SwiftUI는 **View의 상태값을 나타내는 @State를 제공**하여, struct 내의 값을 변경할 수 있도록 도와줍니다. 
- SwiftUI의 View는 Struct로 이루어져있기 때문에, @State를 사용하여 **지속적으로 변형 가능한 변수**를 사용할 수 있습니다.
- 선언한 View 외부에서는 사용할 수 없고, **private 형태로 내부에서만 참조가 가능**합니다.
- 이렇게 보면 View가 직접 @State 값을 갖고 있는 것처럼 보여질 수 있으나, 사실 저장되는 곳은 **View의 외부 메모리에 저장**됩니다.
- 외부 메모리에 저장된 **@State의 값이 변경될 때마다, 변경된 값을 재참조하여 View를 다시 렌더링**하는 방식입니다.
```
1. View 내부에서 @State 선언
2. View 외부 메모리에 @State 값 저장 
3. View 내부에서 @State 변경
4. 이전 @State 값으로 렌더링되어 있는 View 삭제 
5. 외부 메모리에 저장되어 있는 변경된 @State 값을 참조하여 View를 다시 재생성
```
- 위와 같은 사유로 @State의 타입은 복잡한 타입이 아닌 Bool, String과 같은 간단한 타입을 사용하는 것을 권고합니다.

```swift
 struct ContentView: View {
  @State private var text = ""
  
  var body: some View {
    VStack {
      Text(self.text)                              // 2. 변경된 값을 재참조하여 Changed Text 노출
    
      Button(action: { self.text = "Changed Text" }) {      // 1. @State인 text 값을 변경
        Text("텍스트 변경")
      }
    }
  }
}
```

## @Binding

- @Binding은 **부모 view의 @State 값을 받아 양방향으로 연결**되도록 해주는 역할을 제공합니다.
- 두 개의 View가 동시에 하나의 State를 참조해야 하는 경우 사용합니다.

```swift
struct ContentView: View {
  @State var isToggleOn: Bool = true

  var body: some View {
    VStack {
      ChildView(isToggleOn: $isToggleOn)      // Binding<Bool>을 전달하기 위해 $ 삽입
      
      if isToggleOn {
        Text("Show Text")
      }
    }
  }
}


struct ChildView: View {
  @Binding var isToggleOn: Bool
  
  var body: some View {
    Toggle(isOn: $isToggleOn) {
      Text("Show And Hide Text")
    }.Padding()
  }
}
```

- 위와 같이 @Binding Annotation을 사용하여 초기화할 때, 여러 개의 뷰가 동시에 같은 State 값을 참조할 수 있게 됩니다.
- @State 값을 전달할 때 단순히 `isToggleOn`을 전달하면 Bool 값이 전달되지만, `$isToggleOn`처럼 **$가 붙으면 프로퍼티 래퍼 자체를 전달**하기 때문에 자식뷰에서 부모뷰에 선언된 State의 WrappedValue 값을 변경할 수 있게 됩니다. 
- 만약 부모뷰, 자식뷰와 같이 수직적인 구조가 아닌 아예 다른 클래스에서 값을 참조하고 싶다면 `@ObservableObject`를 사용할 수 있습니다.

## @ObservableObject

- @ObservableObject는 Protocol로, Combine 프레임워크의 일부입니다.
- 별도의 클래스를 생성한 다음 SwiftUI에서 사용할 수 있으며, 내부 프로퍼티에 `@Publised`를 붙여 **View에게 해당 값이 변경되었음을 즉각 알려줄 수 있습니다.**
- 사용하는 View에서는 `@ObservedObject`를 선언하여 사용하며, `@Published`가 붙여진 값이 변경될 때마다 View를 다시 그리게 됩니다.
- 만약 `@Published`를 지우고 값을 변경한다면 내부 데이터 값은 변경되지만 UI는 변경되지 않습니다.

```swift
class CountRepo: ObservableObject {
  @Published var count: Int = 0
}

struct ContentView: View {
  @ObservedObject var countRepo = CountRepo()
  
  var body: some View {
    VStack {
      Text("\(self.countRepo.count)")
      
      Button("숫자 증가") {
        
      }
    }
  }
}
```
- 위와 같이 데이터가 변경될 때마다 즉각적으로 UI를 변화시킬 수 있지만, 특정한 조건부 형식으로도 UI를 다시 그릴 수 있습니다. 

```swift
class CountRepo: ObservableObject {
  @Published var count: Int = 0 {
    willSet(newValue) {
      if(newValue % 5 == 0) {
        objectWillChange.send()
      }
    }
  }
}
```

- 위 코드에서 사용한 `objectWillChange.send()`는 **SwiftUI에서 갑이 변동되었음을 알려주는 메소드**로, 해당 메소드가 선언되었을 때만 UI를 변경시킬 수 있습니다.
- 이제 예제에서는 count의 값이 5의 배수일 때만 텍스트가 변경됩니다.
 
## @EnvironmentObject

- @EnvironmentObject는 **각 View마다 별도로 값을 전달해주지 않아도, 상속받는 부모로부터 함께 적용되는 오브젝트**입니다.
- 보통 앱 전반에 걸쳐 공유되는 데이터에 사용되며, `.environmentObject()`를 통해 값을 전달할 수 있습니다.
- 전달하려는 object는 **ObservableObject 프로토콜을 준수**해야 합니다.

```swift
class Settings: ObservableObject {
  @Published var version = 0
  @Published var userName = ""
}

// SceneDelegate.swift
class SceneDelegate: NSObject, UIWindowSceneDelegate {
  let window = UIWindow(windowScene: windowScene)
  let settings = Settings() 
  window.rootViewController = UIHostingController(rootView: ContentView().environmnetObject(settings))
} 

struct ContentView: View {
  @EnvironmentObject var settings: Settings
  
  var body: some Body {
    NavigationView {
      VStack {
        Button(action: {
          self.settings.version += 1
        }) {
          text("Increase version")
        }
        
        Button(action: {
          self.settings.username = "Sangho"
        }) {
          text("Change username")
        }
        
        NavigationLink(destination: DetailView()) {
          Text("Show Detail View")
        }
      }
    }
  }
}

struct DetailView: View {
  @EnvironmentObject var settings: Settings

  var body: some View {
    VStack {
      Text("Version: \(settings.version)")
      Text("User name: \(settings.userName)")
    }
  }
}
```

- 위 예제에서는 SceneDelegate 클래스에서 window.rootViewController에 UIHostingController를 사용하여 ContentView를 최상위 View로 할당하고, environmentObject 메소드를 사용하여 ObservableObject인 Settings를 넘겨주었습니다.
- ContentView의 자식뷰인 DetailView에서 `@EnvironmentObject`를 활용하여 전달된 값에 접근할 수 있습니다.
