//
//  PagerView.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 10.10.2022.
//

import SwiftUI

/// https://gist.github.com/mecid/e0d4d6652ccc8b5737449a01ee8cbc6f
struct PagerView2<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}

struct PagerView1<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 0) {
                    self.content.frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
                .offset(x: self.translation)
                .animation(.interactiveSpring())
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }.onEnded { value in
                        let offset = value.translation.width / geometry.size.width
                        let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                        self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                    }
                )
                
                VStack {
                    Spacer()
                    
                    HStack {
                        ForEach(0..<self.pageCount, id: \.self) { index in
                            Circle()
                                .fill(index == self.currentIndex ? Color.white : Color.gray)
                                .frame(width: 10, height: 10)
                        }
                    }
                }
                .offset(y: 16)
            }
        }
    }
}

public struct PagerViewSample1: View {
//
    let data: [ProductFeature] = [
        ProductFeature(title: "Map", image: "globe"),
        ProductFeature(title: "Plan", image: "map"),
        ProductFeature(title: "Dashboards", image: "square.grid.3x3.fill"),
        ProductFeature(title: "Cameras", image: "video.fill"),
        ProductFeature(title: "All cameras", image: "video.fill.badge.ellipsis"),
        ProductFeature(title: "Actions", image: "bolt.fill"),
        ProductFeature(title: "Events", image: "rectangle.3.group.fill"),
        ProductFeature(title: "Alerts", image: "exclamationmark.triangle"),
        ProductFeature(title: "Face search", image: "person.crop.circle.badge.questionmark"),
        ProductFeature(title: "Lpr search", image: "car"),
        ProductFeature(title: "Persons", image: "person.text.rectangle"),
        ProductFeature(title: "Translation", image: "dot.radiowaves.left.and.right"),
        ProductFeature(title: "Audit", image: "lock.open.display"),
        ProductFeature(title: "Bookmarks", image: "bookmark"),
        ProductFeature(title: "Statistics", image: "chart.xyaxis.line")
    ]
//
//    @State var data1: [ProductFeature] = Array(TabSample1.data.prefix(4))
//    //    @State var data2: [ProductFeature] = Array(data.suffix(from: 4))
//
    @State var selected: Int = 0
    
    public var body: some View {
        //PagerView(data, currentIndex: $selected) { x in
        PagerViewWithDots(data) { x in
            ZStack {
                Color.black
                Text("Row: \(x.title)").foregroundColor(.white)
            }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        }
    }
}

/// https://prafullkumar77.medium.com/swiftui-how-to-create-a-horizontal-paging-scrollview-525a8423ed64
struct PageView: View {
    var body: some View {
        TabView {
            ForEach(0..<30) { i in
                ZStack {
                    Color.black
                    Text("Row: \(i)").foregroundColor(.white)
                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }
            .padding(.all, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 200)
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PagerViewSample111: View {
    var body: some View {
        ScrollView {
            LazyHStack {
                PageView()
            }
        }
    }
}

/// https://swiftuirecipes.com/blog/pager-swiper-view-in-swiftui
struct PagerView<Data, Content>: View
    where Data : RandomAccessCollection, Data.Element : Hashable, Content : View {
  // the source data to render, can be a range, an array, or any other collection of Hashable
  private let data: Data
  // the index currently displayed page
  @Binding var currentIndex: Int
  // maps data to page views
  private let content: (Data.Element) -> Content

  // keeps track of how much did user swipe left or right
  @GestureState private var translation: CGFloat = 0

  // the custom init is here to allow for @ViewBuilder for
  // defining content mapping
  init(_ data: Data,
        currentIndex: Binding<Int>,
        @ViewBuilder content: @escaping (Data.Element) -> Content) {
    self.data = data
    _currentIndex = currentIndex
    self.content = content
  }

  var body: some View {
    GeometryReader { geometry in
      LazyHStack(spacing: 0) {
        // render all the content, making sure that each page fills
        // the entire PagerView
        ForEach(data, id: \.self) { elem in
          content(elem)
            .frame(width: geometry.size.width)
        }
      }
      .frame(width: geometry.size.width, alignment: .leading)
      // the first offset determines which page is shown
      .offset(x: -CGFloat(currentIndex) * geometry.size.width)
      // the second offset translates the page based on swipe
      .offset(x: translation)
      .animation(.interactiveSpring())
      .gesture(
        DragGesture().updating($translation) { value, state, _ in
          state = value.translation.width
        }.onEnded { value in
          // determine how much was the page swiped to decide if the current page
          // should change (and if it's going to be to the left or right)
          // 1.25 is the parameter that defines how much does the user need to swipe
          // for the page to change. 1.0 would require swiping all the way to the edge
          // of the screen to change the page.
          let offset = value.translation.width / geometry.size.width * 1.25
          let newIndex = (CGFloat(currentIndex) - offset).rounded()
          currentIndex = min(max(Int(newIndex), 0), data.count - 1)
        }
      )
    }
  }
}

struct PagerViewWithDots<Data, Content>: View
    where Data : RandomAccessCollection, Data.Element : Hashable, Content : View {
  @State private var currentIndex = 0
  private let data: Data
  private let content: (Data.Element) -> Content

  init(_ data: Data,
       @ViewBuilder content: @escaping (Data.Element) -> Content) {
    self.data = data
    self.content = content
  }

  var body: some View {
    ZStack {
      // let the PagerView and the dots fill the available screen
      Rectangle().foregroundColor(.white)
      // render the Pager View
      PagerView(data, currentIndex: $currentIndex, content: content)
      // the dots view
      VStack {
        Spacer() // align the dots at the bottom
        HStack(spacing: 6) {
          ForEach(0..<data.count) { index in
            Circle()
              .foregroundColor((index == currentIndex) ? .black : .gray)
              .frame(width: 10, height: 10)
           }
         }
       }.padding()
    }
  }
}
