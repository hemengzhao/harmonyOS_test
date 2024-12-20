import { preferences } from '@kit.ArkData'
import { util } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

export class  PreferencesUtil {
  private  dataPreferences: preferences.Preferences | null = null;

  /**
   * 初始化preferences对象
   * */
  init(context: Context, storeName: string){
    let options: preferences.Options = { name: 'myStore' };
    this.dataPreferences = preferences.getPreferencesSync(context, options);

    // 订阅数据变更。
    let observer = (key: string) => {

      // 数据持久化
      this.dataPreferences!.flush((err: BusinessError) => {
        if (err) {
          console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info('Succeeded in flushing.');
      })
    }
    this.dataPreferences.on('change', observer);

  }

  insert(key: string, value: string){
    if(!this.dataPreferences) return
    if (this.dataPreferences.hasSync(key)) {
      console.info(`已经存在key： ${key}`);
    } else {
      console.info("The key 'startup' does not contain.");
      // 此处以此键值对不存在时写入数据为例
      this.dataPreferences.putSync(key, value);
      // 当字符串有特殊字符时，需要将字符串转为Uint8Array类型再存储
      // let uInt8Array1: string = new util.TextEncoder().encodeInto("~！@#￥%……&*（）——+？");
      // this.dataPreferences.putSync('uInt8', uInt8Array1);



    }
  }


  readData(key: string, value?: string){


    if(!this.dataPreferences) return ''

    let val = this.dataPreferences.getSync(key, value ? value : 'default');
    console.info("The 'startup' value is " + val);
    // 当获取的值为带有特殊字符的字符串时，需要将获取到的Uint8Array转换为字符串
    // let uInt8Array2 : preferences.ValueType = this.dataPreferences.getSync('uInt8', new Uint8Array(0));
    // let textDecoder = util.TextDecoder.create('utf-8');
    // val = textDecoder.decodeToString(uInt8Array2 as Uint8Array);
    // console.info("The 'uInt8' value is " + val);

    return val
  }
}

const preferencesUtil = new PreferencesUtil()
export {
  preferencesUtil
}