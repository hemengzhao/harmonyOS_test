import { formatDate } from '../../uilt/date';
import { ETaskType, TaskItem, taskType } from '../../viewmodel/task';

@Extend(Text) function TextStyle(){
  .width('100%')
  .fontSize(24)
  .margin({bottom: 10})

}
@Entry
@Component
struct AddTaskPage {
  @State name: string = '';
  @State date:string = ''
  @State startTime: string = ''
  @State endTime: string = ''
  @State type: ETaskType = ETaskType.PERSONAL
  @State describe: string = ''
  timePickerChange = (type: 'start' | 'end') => {
    TimePickerDialog.show({
      selected: type === 'start' ? new Date(this.startTime) : new Date(this.endTime),
      useMilitaryTime: true,
      onAccept: (value) => {
        if(type === 'start'){
          this.startTime = `${value.hour}-${value.minute}`
        } else {
          this.endTime= `${value.hour}-${value.minute}`
        }
      },

    })
  }
  calendarChange = () => {
    CalendarPickerDialog.show({
      selected: new Date(this.date),
      onAccept: (value) => {
          console.log(JSON.stringify(value))
        this.date = formatDate(value.getTime())
      }
    })
  }

  addTask () {
    // const obj: TaskItem = new TaskItem(1, this.name)
    console.log(JSON.stringify({
      name: this.name,
      date: this.date,
      startTime: this.startTime,
      endTime: this.endTime,
      type: this.type,
      describe: this.describe
    }))
  }
  build() {
     Column({
       space: 20
     }){
       Column(){
         Text('标题').TextStyle()
         TextInput({
           placeholder: '请输入任务名称',
           text: $$this.name
         }).fontSize(20).placeholderFont({
           size: 20
         }).placeholderColor(Color.Black).backgroundColor(Color.White)
         Divider().strokeWidth(2).color(Color.Black).lineCap(LineCapStyle.Round)
       }.width('100%')
       .alignItems(HorizontalAlign.Start)
       Column(){
         Text('日期').TextStyle()
         TextInput({
           placeholder: '请选择日期',
          text: $$this.date
         }).onClick(this.calendarChange).fontSize(20).placeholderFont({
           size: 20
         }).placeholderColor(Color.Black).backgroundColor(Color.White)
         Divider().strokeWidth(2).color(Color.Black).lineCap(LineCapStyle.Round)

       }
       Column(){
         Text('时间').TextStyle()
         Row(){
           TextInput({
             placeholder: '请选择时间',
             text: $$this.startTime
           }).onClick(() => this.timePickerChange('start')).fontSize(20).placeholderFont({
             size: 20
           }).placeholderColor(Color.Black).backgroundColor(Color.White).width('45%')

           TextInput({
             placeholder: '请选择时间',
             text: $$this.endTime
           }).onClick(() => this.timePickerChange('end')).fontSize(20).placeholderFont({
             size: 20
           }).placeholderColor(Color.Black).backgroundColor(Color.White).width('45%')
         }.justifyContent(FlexAlign.SpaceBetween).width('100%')

         Divider().strokeWidth(2).color(Color.Black).lineCap(LineCapStyle.Round)
       }

       Column(){
         Text('描述').TextStyle()
         TextInput({
           placeholder: '请输入任务描述',
           text: $$this.describe
         }).fontSize(20).placeholderFont({
           size: 20,


         }).placeholderColor(Color.Black).backgroundColor(Color.White)
         Divider().strokeWidth(2).color(Color.Black).lineCap(LineCapStyle.Round)
       }.width('100%')
       .alignItems(HorizontalAlign.Start)

       Column(){
         Text('类型').TextStyle()
          Row(){
           ForEach(Object.entries(taskType), (item: [key: ETaskType, value: string], index) => {
             Row(){
               Radio({ value: item[0], group: 'type' })
                 .checked(this.type === item[0])
                 .onClick((value) => {
                  if(value){
                    this.type = item[0]
                  }
               })
               Text(item[1])
             }
           })
          }.justifyContent(FlexAlign.SpaceBetween).width('100%')

       }.width('100%')
       .alignItems(HorizontalAlign.Start)
      Button('添加任务').width('80%').margin({top: 20})
        .onClick(() => this.addTask())
     }.padding(10)
  }
}