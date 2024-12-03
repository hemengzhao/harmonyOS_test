import { formatDate } from '../../uilt/date';
import { ETaskState, ETaskType, TaskItem, taskType } from '../../viewmodel/task';
import { router } from '@kit.ArkUI';

@Extend(Text) function TextStyle(){
  .width('100%')
  .fontSize(24)
  .margin({bottom: 10})

}
@Entry
@Component
struct AddTaskPage {
  @StorageProp('taskList') list: TaskItem[] =[]
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
        this.date = formatDate(value.getTime(), 'YYYY-MM-DD')
      }
    })
  }

  addTask () {

    let message: string = ''

    if(!this.describe){
      message='请填写描述信息'
    }
    if(!this.startTime || !this.endTime){
      message= '请选择时间'
    }
    if(!this.date){
      message= '请选择日期'
    }
    if(!this.name){
      message= '请填写标题信息'
    }
    if(message){
      AlertDialog.show({
        title: '请填写完整信息',
        message: message,
      })
      return
    }
    const state = [ETaskState.DONE, ETaskState.UNDONE, ETaskState.WAIT, ETaskState.FUTURE][Math.floor(Math.random() * 4)]
    const task = new TaskItem(new Date().getTime(), this.name, this.date, this.startTime,this.endTime, this.type, state , this.describe)
    AppStorage.setOrCreate('taskList', this.list.concat([task]) );
    router.back()
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