import { CartModel, EmptyView } from '@ohos/common'
import { ProductItem } from './ProductItem'

@Component
export struct Cart {
  @State selectAll: boolean = false
  @State sumPrice: number = 0
  @State carts: CartModel[] = []

  aboutToAppear(): void {
    const cart1 = new CartModel()
    cart1.id = 1
    cart1.goods_name = '阿是大赛'
    cart1.goods_big_logo = 'asdas'
    cart1.goods_code = '001'
    cart1.goods_price = 321
    cart1.goods_count = 1
    cart1.goods_checked = 0

    const cart2 = new CartModel()
    cart2.id = 2
    cart2.goods_name = '阿是大赛'
    cart2.goods_big_logo = 'asdas'
    cart2.goods_code = '002'
    cart2.goods_price = 321
    cart2.goods_count = 1
    cart2.goods_checked = 0

    this.carts.push(cart1)
    this.carts.push(cart2)
  }

  @Builder
  ButtonMenu() {
    Row() {
      Row() {
        Checkbox({
          name: "checkbox", group: 'checkboxGroup'
        }).selectedColor('@ed6f21')
          .select(this.selectAll).onClick(() => {
          this.selectAll = !this.selectAll
        })
        Text('全选').fontSize(14).fontColor(Color.Gray)
      }

      Row({ space: 10 }) {
        Text('总价').fontSize(16).fontWeight(FontWeight.Bold)

        Text(`¥${this.sumPrice}`).fontSize(16)
          .fontColor(Color.Brown)


        Button('结算', {
          type: ButtonType.Capsule, stateEffect: true
        })
          .backgroundColor('#e92f4f')
          .fontSize(16)
          .fontColor(Color.Brown)
          .height(40)
          .width(100)
          .onClick(() => {

          })
      }

    }.width('100%')
    .height(70)
    .backgroundColor(Color.White)
    .justifyContent((FlexAlign.SpaceBetween))
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Text('购物车')
        .fontSize(24)
        .height(86)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ left: 24 })

      Scroll() {
        Column() {
          if (this.carts.length === 0) {
            EmptyView()
          } else {
            ForEach(this.carts, (item: CartModel, index: number) => {
              ProductItem()
            }, (item: CartModel, index: number) => item.id?.toString())
          }
        }
        .width('100%')
        .height('100%')
      }.scrollBar(BarState.Off)
      .margin({
        left: 12, right: 12
      })
      .flexGrow(1)

      this.ButtonMenu()
    }
  }
}