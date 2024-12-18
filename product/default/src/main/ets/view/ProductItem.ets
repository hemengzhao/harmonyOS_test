import { CartModel } from "@ohos/common"

@Component
export struct ProductItem {
  @ObjectLink Item: CartModel
  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      Text('商品')
      Column() {
        Checkbox({
          name: 'checkbox'
        }) {

        }
        .selectedColor('#ed6f21')
        .select(this.Item.goods_checked === 1)
        .onClick(() => {

        })

      }.width(85)

      Column() {
         Image(this.Item.goods_big_logo)
           .width(100)

      }

      Column() {
        Text(this.Item.goods_name)
          .maxLines(2)
          .textOverflow({overflow: TextOverflow.Ellipsis})
        Text(`¥${this.Item.goods_price}`).fontColor(Color.Brown)
          .fontSize(18)
        Row(){
          Text('-').fontSize(18).width(20)
            .lineHeight(24)
          Text(`${this.Item.goods_count}`)
            .fontSize(20).fontColor(Color.Black)
            .width(20)
            .lineHeight(24)
            .textAlign(TextAlign.Center)
          Text('+').fontSize(18).width(20)
            .lineHeight(24)
        }

      }

    }.width('100%')
    .height(130)
    .backgroundColor(Color.White)
    .borderRadius(10)
  }
}