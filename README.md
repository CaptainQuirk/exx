# Exx

Sometimes you need to switch between the latest xcode version and an ancient
ones.

## Installation

- Clone this repo ```git clone https://github.com/CaptainQuirk/exx <path>```

## Commands

- ```info```: Prints the current xcode version
- ```ls```: List all installed xcode versions
- ```switch <version>```: Switch to a specified version of Xcode
- ```update```: Backs up the current Xcode.app and upgrade via __softwareupdate__
- ```reset```: Resets Xcode version to the latest
- ```install```: Install `exx` globally

## Directory Structure

* Exx expects the ancient Xcode versions to be installed in /Applications with
the following folder structure

```
/Applications/Xcode
├── 5.1
│   └── Xcode.app
├── 6.1
│   └── Xcode.app
├── 6.4
│   └── Xcode.app
└── 7.1
    └── Xcode.app
```

## Credits

This project was built with [sub](https://github.com/basecamp/sub)
