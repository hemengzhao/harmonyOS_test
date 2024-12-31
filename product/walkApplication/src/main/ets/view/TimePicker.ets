import { formatDate } from "../utils/date"

@Component
export struct MyTimePicker{
   @State private cascade: TextCascadePickerRangeContent[] = [
    {
      text: '现在出发',
      children: [{ text: '-', children: [{ text: '-' }] }]
    },
  ]

  createChildren = () => {
    const houses: TextCascadePickerRangeContent[] = [];
    for (let i = 0; i < 12; i++) {
      const pointText = i < 10 ? `0${i}` : `${i}`;
      const children: TextCascadePickerRangeContent[] = [];

      for (let j = 0; j < 12; j++) {
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
    for (let index = 0; index < [0,1,2,3, 4].length; index++) {
      const date = formatDate(today.getTime() + index * 24 * 60 *60 *1000, 'MM月DD日W')
      this.cascade.push({
          text: index ? '今天' : date,
          children: this.createChildren()
        })
    }
  }
  build() {

     Flex({
       direction: FlexDirection.Column
     }){
       TextPicker({ range: this.cascade }).onChange((value: string | string[], index: number | number[]) => {
         console.info('TextPicker 多列联动:onChange ' + JSON.stringify(value) + ', ' + 'index: ' + JSON.stringify(index))
       })
     }

  }
}