# DrivenCLI
Command Line Interface written in Swift.

## Installation guide

##### Clone the repository and navigate to the project directory
```
git clone https://github.com/Arman1997/DrivenCLI.git
cd DrivenCLI
```

##### Build the project
This may take a while.
```
swift build -c release --verbose
```

##### Move the executable to a directory in the system's PATH
```
sudo mv .build/release/DrivenCLI /usr/local/bin/driven
```

##### Verify the installation
```
driven -h
```
