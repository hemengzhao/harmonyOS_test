import { formatDate } from "../utils/date"
@CustomDialog
@Component
export struct MyTimePicker{
  controller?: CustomDialogController
  @State selectedValues: number[] = []
   @State private cascade: TextCascadePickerRangeContent[] = [
    {
      text: '现在出发',
      children: [{ text: '-', children: [{ text: '-' }] }]
    },
  ]
   cancel: () => void = () => {}
   confirm: (v: number[]) => void= (v) => {}

  createChildren = (isToday: boolean) => {
    const houses: TextCascadePickerRangeContent[] = [];
    const nowHours = new Date().getHours()
    const nowMinute = new Date().getMinutes()

    for (let i = 0; i < 24; i++) {
      if(isToday && i < nowHours){
        continue
      }
      const pointText = i < 10 ? `0${i}` : `${i}`;
      const children: TextCascadePickerRangeContent[] = [];

      for (let j = 0; j < 12; j++) {
        if(isToday && i === nowHours && nowMinute > j * 5){
          continue
        }
        const minuteText = j * 5 < 10 ? `0${j * 5}` : `${j * 5}`;
        children.push({
          text: minuteText+'分',
        });
      }

      houses.push({
        text: `${pointText}点`,
        children: children,
      });
    }
    return houses
  }
  aboutToAppear(): void {
    const today = new Date()
    for (let index = 0; index < 5; index++) {
      const date = formatDate(today.getTime() + index * 24 * 60 *60 *1000, 'MM月DD日W')
      this.cascade.push({
          text: index ? date : '今天',
          children: this.createChildren(index === 0)
        })
    }
  }
  build() {
    Column(){
      Flex({
        direction: FlexDirection.Column
      }){
        Row(){
          Text('选择触发时间').fontColor('#333333').fontSize(22).fontWeight(FontWeight.Bold)
          Text('X').fontSize(24).onClick(this.cancel)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%')
        .alignItems(VerticalAlign.Center)

        TextPicker({ range: this.cascade,
        selected: this.selectedValues})
          .onChange((value: string | string[], index: number | number[]) => {
            this.selectedValues = index as number[]
          console.info('TextPicker 多列联动:onChange ' + JSON.stringify(value) + ', ' + 'index: ' + JSON.stringify(index))
        }).margin({
          top: 40,
          bottom: 30
        }).selectedTextStyle({
          color: '#333333',
          font: {
            size: 22,
            weight: FontWeight.Bold
          }
        }).canLoop(false)
          .gradientHeight('30%')

        Column(){
          Button('确认')
            .type(ButtonType.Normal)
            .borderRadius(10)
            .width('80%')
            .backgroundColor('#333333')
            .fontColor('#99DC64')
            .fontSize(20).height(50).onClick(() => {
              console.log(JSON.stringify(this.selectedValues))

              this.confirm(this.selectedValues)
          })
        }
        .alignItems(HorizontalAlign.Center).width('100%')
      }.padding(20)
      .height(400)
      .borderRadius({
        topLeft: 30,
        topRight: 30
      })
    }
  }
}