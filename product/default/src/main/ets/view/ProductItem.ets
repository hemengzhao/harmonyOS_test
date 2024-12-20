import { CartModel, cartDBUtils } from "@ohos/common"
import { relationalStore } from "@kit.ArkData"

@Component
export struct ProductItem {
  private computedTotalPrice = () => {}
  @ObjectLink @Watch('change') Item: CartModel
  change(){
    this.computedTotalPrice()
  }

  coupendCount = (isAdd?: boolean) => {
    if(!isAdd && this.Item.goods_count === 1){
      return
    }
    if(isAdd){
      this.Item.goods_count! += 1
    } else {
      this.Item.goods_count! -= 1
    }

    const updateColum: relationalStore.ValuesBucket = {
      GOODS_COUNT: this.Item.goods_count as number
    }
    cartDBUtils.updateById('MYCART', Number(this.Item.id), updateColum )
  }
  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {

      Column() {
        Checkbox({
          name: 'checkbox'
        }) {

        }
        .selectedColor('#ed6f21')
        .select(this.Item.goods_checked === 1)
        .onClick(() => {
          this.Item.goods_checked = this.Item.goods_checked ? 0 : 1
        })
      }.width(85)

      Column() {
         Image(this.Item.goods_big_logo)
           .width(100)
      }.width(100).margin({left: 20, right: 20})

      Column() {
        Text(this.Item.goods_name)
          .maxLines(2)
          .textOverflow({overflow: TextOverflow.Ellipsis})
        Text(`¥${this.Item.goods_price}`).fontColor(Color.Brown)
          .fontSize(18)
        Row(){
          Text('-').fontSize(18).width(35).padding({left: 10, right: 10}).border({
            width: 1,
            color: Color.Gray
          }).borderRadius(15).textAlign(TextAlign.Center)
            .lineHeight(20).onClick(() => {
              this.coupendCount(false)
          })
          Text(`${this.Item.goods_count}`)
            .fontSize(20).fontColor(Color.Black)
            .width(40)
            .lineHeight(24)
            .textAlign(TextAlign.Center)
          Text('+').fontSize(18).width(35).padding({left: 10, right: 10}).border({
            width: 1,
            color: Color.Gray
          }).borderRadius(15).textAlign(TextAlign.Center)
            .lineHeight(20).onClick(() => {
            this.coupendCount(true)
          })
        }
      }.margin({left: 20})

    }.width('100%')
    .height(130)
    .backgroundColor(Color.White)
    .borderRadius(10)
  }
}