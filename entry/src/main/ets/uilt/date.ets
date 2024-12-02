

export const formatDate = (time: number | string | Date, format: string = 'YYYY-MM-DD HH:mm:ss') => {
    const date = new Date(time)
    const year = date.getFullYear().toString();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    const seconds = date.getSeconds().toString().padStart(2, '0');
  const milliseconds = date.getMilliseconds().toString().padStart(3, '0');
  const weekday = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'][date.getDay()]
  const quarter = Math.floor((date.getMonth() + 1) / 3);

  const formatMap: Record<string,  string> = {
    'YYYY': year,
    'MM': month,
    'DD': day,
    'HH': hours,
    'mm': minutes,
    'ss': seconds,
    'SSS': milliseconds,
    'W': weekday,
    'Q': quarter.toString().padStart(2, '0'),
  };

  return format.replace(/(YYYY|MM|DD|HH|mm|ss|SSS|W|Q)+/g, (match: string)  => {
    return formatMap[match] || match;
  });
}


export  const getRandomDate = (start: number | string | Date, end: number | string | Date) => {
  // 将开始和结束日期转换为时间戳
  const startDate = new Date(start).getTime();
  const endDate = new Date(end).getTime();

  // 生成随机时间戳
  const randomTimestamp = startDate + Math.random() * (endDate - startDate);

  // 将随机时间戳转换回日期
  const randomDate = new Date(randomTimestamp);

  return randomDate
}