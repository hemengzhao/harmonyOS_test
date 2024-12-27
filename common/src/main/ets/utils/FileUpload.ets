import { common } from "@kit.AbilityKit";
import fs from '@ohos.file.fs';
import { BusinessError, request } from "@kit.BasicServicesKit";
import { picker } from "@kit.CoreFileKit";
import { photoAccessHelper, PickerOptions, ReminderMode } from "@kit.MediaLibraryKit";

// （1） 获取应用文件路径
let context = getContext(this) as common.UIAbilityContext

// 获取到会换成的文件路径
let cacheDir = context.cacheDir;

export  function  copyImgToCache(photoImgPath: string){
  const file = fs.openSync(photoImgPath, fs.OpenMode.READ_ONLY);

  // file文件唯一id
  let fileId = file.fd;
  let fileName = Date.now().toString()
  const  ext = 'jpg'
  let fullPath = cacheDir + '/' + fileName + '.' + ext
  fs.copyFileSync(fileId, fullPath)
  // { filename: 'test.txt', name: 'test', uri: 'internal://cache/test.txt', type: 'txt' }
  return [`internal://cache/${fileName}.${ext}`, fileName + '.' + ext]

}

// 选择图片
function  PickerPhoto(){
  console.log('选择图片')
  const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
  photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
  photoSelectOptions.maxSelectNumber = 5; // 选择媒体文件的最大数目

  let uris: Array<string> = []
  const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
  photoViewPicker.select(photoSelectOptions).then((photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
    uris = photoSelectResult.photoUris;
    console.info('photoViewPicker.select to file succeed and uris are:' + uris);
  }).catch((err: BusinessError) => {
    console.error(`Invoke photoViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
  })
}
/**
 * 封装文件上传的函数
 * */
export async  function FileUpload(imgSrc: string){
  console.log('封装文件上传的函数')
  PickerPhoto()
  // // 新建一个本地应用文件
  // let file = fs.openSync(cacheDir + '/test.txt', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  // // 往文件写入数据
  // fs.writeSync(file.fd, 'upload file test');
  // // 关闭写入
  // fs.closeSync(file);


 const arrayy = await copyImgToCache(imgSrc)

  // 上传任务配置项
  let files: Array<request.File> = [
  //uri前缀internal://cache 对应cacheDir目录
    { filename: arrayy[1], name: 'test', uri: arrayy[0], type: 'jpg' }
  ]
  let data: Array<request.RequestData> = [{ name: 'name', value: 'value' }];
  let uploadConfig: request.UploadConfig = {
    url: 'https://xxx',
    header: {
      'key1':'value1',
      'key2':'value2',
    },
    method: 'POST',
    files: files,
    data: data
  }


  // 将本地应用文件上传至网络服务器
  try {
    request.uploadFile(context, uploadConfig)
      .then((uploadTask: request.UploadTask) => {
        uploadTask.on('complete', (taskStates: Array<request.TaskState>) => {
          for (let i = 0; i < taskStates.length; i++) {
            console.info(`upload complete taskState: ${JSON.stringify(taskStates[i])}`);
          }
        });
      })
      .catch((err: BusinessError) => {
        console.error(`Invoke uploadFile failed, code is ${err.code}, message is ${err.message}`);
      })
  } catch (error) {
    let err: BusinessError = error as BusinessError;
    console.error(`Invoke uploadFile failed, code is ${err.code}, message is ${err.message}`);
  }
}