# Loans demo app
Loans demo app for iPhone & iPad (iOS 8+).

## Usage
- Clone the repo
- Run `pod install` from project directory.
- Open project Loans.xcworkspace

If you change the CoreData model, remember to run the following command on `./Loans/Model` directory:

`mogenerator -m Model.xcdatamodeld/ -M ./Machine/ -H ./Human/ --template-var arc=true`


## Tools/Libraries/SDKs used
#### Views
- MapKit
- [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet)
- [SVProgressHUD](https://github.com/TransitApp/SVProgressHUD)

#### Persistence
- CoreData
- [MagicalRecord](https://github.com/magicalpanda/MagicalRecord)
- [mogenerator](https://github.com/rentzsch/mogenerator)

#### Networking
- [AFNetworking](https://github.com/AFNetworking/AFNetworking)

#### Others
- [ReactiveCocoa 2.5](https://github.com/ReactiveCocoa/ReactiveCocoa)

## Author
Luis Valdés Cuesta

[luis (DOT) valdes (DOT) cuesta (AT) gmail.com]()

## License
(The MIT License)

Copyright (c) 2015 Luis Valdés Cuesta

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.