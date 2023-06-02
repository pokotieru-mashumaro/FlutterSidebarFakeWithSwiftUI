//
//  SideBarView.swift
//  FlutterSidebarFakeWithSwiftUI
//
//  Created by 小松虎太郎 on 2023/06/03.
//

import SwiftUI

struct SideBarView: View {
    @EnvironmentObject var vm: SideBarViewModel
    var body: some View {
        VStack {
            userAndDB()
                .padding(.horizontal)
                .padding(.top, 30)

            TabItemAndAnimation()

            Spacer()

            DarkToggle(vm: _vm)
        }
        .frame(maxWidth: 230, maxHeight: .infinity)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    func userAndDB() -> some View {
        VStack(spacing: 20) {
            HStack(spacing: 18) {
                Text("名前").bold()
                    .foregroundColor(.gray)
                    .font(.callout)

                Spacer()

                Button {
                    withAnimation(.easeIn) {
                        vm.isOpen = false
                        vm.sideButton = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }

            VStack {
                Text("ここは名前のところだよ").bold()
                    .font(.title2)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    @ViewBuilder
    func TabItemAndAnimation() -> some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 1)
                .opacity(0.2)
                .foregroundColor(.white)
                .padding(.horizontal)

            ForEach(sidebar) { item in
                Button {
                        vm.selectedItem = item.tab

                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: item.icon)
                            .font(.headline)

                        Text(item.title)
                            .font(.title3)
                    }
                    .foregroundColor(vm.selectedItem == item.tab ? .white : .gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
        }
        .frame(width: 300)
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
            .environmentObject(SideBarViewModel())
    }
}

struct DarkToggle: View {
    @EnvironmentObject var vm: SideBarViewModel
    var body: some View {
        HStack {
            Image(systemName: "gearshape")
            Text("ダークモード")
            Spacer()
            Toggle(isOn: $vm.toggleAction) {

            }
            .frame(width: 50, height: 50)
        }
        .padding()
        .foregroundColor(.white)
    }
}
