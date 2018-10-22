react-native-image-to-base64
============================

## Installation 🚀

- Run `npm install react-native-image-to-base64 --save`
- Run `react-native link react-native-image-to-base64` (RN 0.29.1+, otherwise `rnpm link react-native-image-to-base64`)

## Usage 💃

| Property | Type | Parameters | Description |
|-----------------|----------|----------|--------------------------------------------|
| `getBase64String` | `Function` | `(uri: string, inSampleSize: int (ANDROID ONLY, NOT REQUIRED))` | Function to get the base 64 string, first parameter is the URI of the file, second is ANDROID ONLY and is to set how the image must be subsampled by the decoder |

```javascript
import ImgToBase64 from 'react-native-image-to-base64';

try {
  const base64string = await ImgToBase64.getBase64String(path, 1)
  console.log(base64string)
  // Do something with base64
} catch(error) {
  console.log(error)
}
```
