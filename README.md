# Loans demo app

Loans demo app for iPhone & iPad.

## Usage

- Clone the repo
- Run `pod install` from project directory.
- Open project Loans.xcworkspace

If you change the CoreData model, remember to run the following command on ./Loans/Model directory:

mogenerator -m Model.xcdatamodeld/ -M ./Machine/ -H ./Human/ --template-var arc=true


## Tools & Libraries used

...
mogenerator 1.29


## Author

Luis Valdés Cuesta
luis.valdes.cuesta@gmail.com
