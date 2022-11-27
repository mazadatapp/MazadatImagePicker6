# mazadat-image-picker6

Mazadat Image Picker

## Installation

```sh
npm install mazadat-image-picker6
```

## Usage

```js
import { openCamera,openGallery,editPhoto } from 'mazadat-image-picker6';

// ...

const result = await openCamera('title',3, 7);
const result = await openGallery('title',3, 7);
const result = await editPhoto('title','path/to/the/image',3, 7);
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
