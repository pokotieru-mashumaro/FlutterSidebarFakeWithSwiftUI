//
//  ContentView.swift
//  FlutterSidebarFakeWithSwiftUI
//
//  Created by 小松虎太郎 on 2023/06/03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: SideBarViewModel

    //サイドバー関係
    private let width = UIScreen.main.bounds.width
    @State private var viewState = CGSize.zero
    @State private var isSwipe: Bool = false
    @State private var rotaProgress: CGFloat = 0

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            SideBarView()
                .opacity(vm.isOpen ? 1 : 0)

            ZStack {
                Color(uiColor: .systemGray5)
                    .cornerRadius(vm.isOpen ? 30 : isSwipe ? 30 : 0)
                    .ignoresSafeArea()

                HomeView()

                Button {
                    withAnimation(.easeIn) {
                        vm.isOpen.toggle()
                        vm.sideButton.toggle()
                        rotaProgress = 30
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 30, height: 20)
                }
                .padding()
                .background(Circle().fill(.white))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
            }
            .offset(x: vm.isOpen ? 250 : viewState.width)
            .rotation3DEffect(.degrees(rotaProgress), axis: (x: 0, y: vm.isOpen ? -1 : isSwipe ? -1 : 0, z: 0))

        }
        .gesture(
            DragGesture().onChanged { value in
                let width = value.translation.width
                guard width >= 0 else { return }
                rotaProgress = width < 30 ? width : 30
                print(rotaProgress)
                if vm.isOpen {
                    //サイドバー表示中

                } else {
                    //通常画面
                    guard width > 0 else { return }
                    self.isSwipe = true
                    self.viewState = value.translation
                }
            }
                .onEnded { value in
                    withAnimation(.easeOut(duration: 0.02).speed(0.7)) {
                        if value.predictedEndTranslation.width > width / 4 {
                            vm.isOpen  = true
                            vm.sideButton = true

                        }

                        self.isSwipe = false
                        self.viewState = CGSize.zero
                    }
                }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SideBarViewModel())
    }
}
