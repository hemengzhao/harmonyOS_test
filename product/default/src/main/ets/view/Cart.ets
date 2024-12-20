import { cartDBUtils, CartModel, EmptyView } from '@ohos/common'
import { ProductItem } from './ProductItem'
@Entry
@Component
export struct Cart {
  @State @Watch('checkoutAll')  selectAll: boolean = false
  @State sumPrice: number = 0
  @State   carts: CartModel[] = []

  computedTotalPrice = () => {

     const result =  this.carts.reduce((sum: number, item:CartModel ) =>{
        if(item.goods_checked){
          sum += (item.goods_price as number) * (item.goods_count as number)
        }
       return sum
     }, 0)
    this.sumPrice = result
  }

  checkoutAll(targetKey: string) {
    console.log('targetKey: ' + targetKey)
    this.carts.forEach((item: CartModel) => {
      item.goods_checked = this.selectAll ? 1 : 0
    })
  }

  findDBCartData =async () => {
   const res = await cartDBUtils.queryDataDB(['ID', 'GOODS_NAME', 'GOODS_COUNT', 'GOODS_BIG_LOGO', 'GOODS_CODE', 'GOODS_PRICE', 'GOODS_CHECKED'], 'MYCART')
    console.log(`findDBCartData ===> res: ${JSON.stringify(res)}`)
   this.carts = res
  }
  aboutToAppear(): void {
    this.findDBCartData()

  }

  @Builder
  ButtonMenu() {
    Row() {
      Row() {
        Checkbox({
          name: "checkbox", group: 'checkboxGroup'
        }).selectedColor('#ed6f21')
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

  @Builder itemEnd(index: number){
    Row(){
      Button('删除').onClick(() => {
          this.carts.splice(index, 1)
      })
    }
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
        Column( ) {
          if (this.carts.length === 0) {
            EmptyView()
          } else {
            List({space: 20}){
              ForEach(this.carts, (item: CartModel, index: number) => {
                ListItem(){
                  ProductItem({Item: item, computedTotalPrice: this.computedTotalPrice})
                }
                .swipeAction({
                  end: {
                    builder: () => {this.itemEnd(index)}
                  }
                })
              }, (item: CartModel, index: number) => item.id?.toString())
            }

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
    }.backgroundColor('#f1f3f5')
  }
}