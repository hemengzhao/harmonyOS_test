import { distributedKVStore } from "@kit.ArkData";
import { BusinessError } from "@kit.BasicServicesKit";

export class KVStore {
  private kvManager: distributedKVStore.KVManager | undefined = undefined
 private kvStore: distributedKVStore.SingleKVStore | undefined = undefined;
  // 数据库创建
  init(context: Context){
    // 定义数据库初始化需要的字段
    const kvManagerConfig: distributedKVStore.KVManagerConfig = {
      context: context,
      bundleName: 'com.example.myapplication'
    };
    try {
      // 创建KVManager实例
      this.kvManager = distributedKVStore.createKVManager(kvManagerConfig);
      console.info('Succeeded in creating KVManager.');
      // 继续创建获取数据库
    } catch (e) {
      let error = e as BusinessError;
      console.error(`Failed to create KVManager. Code:${error.code},message:${error.message}`);
    }
  }

  //
  createStore(storeId: string){
    try {
      const options: distributedKVStore.Options = {
        createIfMissing: true,
        encrypt: false,
        backup: false,
        autoSync: false,
        // kvStoreType不填时，默认创建多设备协同数据库
        kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
        // 多设备协同数据库：kvStoreType: distributedKVStore.KVStoreType.DEVICE_COLLABORATION,
        securityLevel: distributedKVStore.SecurityLevel.S1
      };
      this.kvManager!.getKVStore<distributedKVStore.SingleKVStore>(storeId, options, (err, store: distributedKVStore.SingleKVStore) => {
        if (err) {
          console.error(`Failed to get KVStore: Code:${err.code},message:${err.message}`);
          return;
        }
        console.info('Succeeded in getting KVStore.');
        this.kvStore = store;
        // 请确保获取到键值数据库实例后，再进行相关数据操作
      });
    } catch (e) {
      let error = e as BusinessError;
      console.error(`An unexpected error occurred. Code:${error.code},message:${error.message}`);
    }
  }

  insert(key: string, value: string){
    try {
      this.kvStore!.put(key, value, (err) => {
        if (err !== undefined) {
          console.error(`Failed to put data. Code:${err.code},message:${err.message}`);
          return;
        }
        console.info('Succeeded in putting data.');
      });
    } catch (e) {
      let error = e as BusinessError;
      console.error(`An unexpected error occurred. Code:${error.code},message:${error.message}`);
    }
  }

  getData(key: string){
    return new Promise((resolve: (value: string | number | boolean | Uint8Array) => void, reject: (value?: string) => void) => {
      this.kvStore!.get(key, (err, data) => {
        if (err != undefined) {
          console.error(`Failed to get data. Code:${err.code},message:${err.message}`);
          reject('查询失败')
          return;
        }
        console.info(`Succeeded in getting data. Data:${data}`);
        resolve(data)
      });
    })

  }
}


 const kvStore = new KVStore()

export {
  kvStore
}
