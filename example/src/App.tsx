import * as React from 'react';

import { StyleSheet, View, Text, Button, Image } from 'react-native';
import { multiply,openCamera,openGallery,editPhoto } from 'mazadat-image-picker6';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>();

  const test = () => {
    const path='/var/mobile/Containers/Data/Application/C641A8CD-A68E-450E-8EED-3A261B517F91/Documents/photo.png'
    openCamera('Scan Front Side',4, 3).then((value) => {
      setResult(value)
      console.log(result)
    });
  }
  //var/Users/Karim.Saad/Library/Developer/CoreSimulator/Devices/695AB26E-3F38-4E7B-87A6-49B4AA1D84BA/data/Containers/Data/Application/6388206E-6ACA-44B1-A545-661E0B5D4DD2/Documents/photo.png
  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
      <Button title='test' onPress={test}></Button>
      <Image style={styles.imgBanner} source={{uri:'file://'+ result}}></Image>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },imgBanner: {
    height: 75,
    width: 100,
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
