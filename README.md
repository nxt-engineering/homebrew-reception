# [Homebrew 🍺](https://brew.sh) tap for [reception](https://github.com/nxt-engineering/reception).

## Usage

```bash
brew tap nxt-engineering/homebrew-reception
brew install reception
```

## How to bottle

```
brew uninstall reception
brew install --build-bottle reception
brew bottle reception
```

1. Copy the output to `Formula/reception.rb`.
2. Commit & Push the change.
3. Create a new release called "v{VERSION_FROM_TAR_GZ_FILE}".
   file.
4. Attach the tar.gz file to the release

## About

This tap is currently maintained and funded by [nxt](https://nxt.engineering/en/).
