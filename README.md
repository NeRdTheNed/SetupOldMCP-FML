# Setup old MCP / FML

> Shell scripts to automatically set up old versions of MCP and FML

Scripts:

-   setupFML1.2.5.sh: downloads and sets up a FML 1.2.5 environment.  
    Requirements: curl, unzip, dos2unix if not on Windows.  
    Python 2 and Java are required for MCP setup (JDK 6 recommended, JDK 7 works as well).

## Using specific JDK versions

### macOS

On macOS, setting the version of Java used is generally very simple:

```shell
export JAVA_HOME=/path/to/java/home
```

### Linux

On Linux, setting the version of Java used has a few more steps. Suppose your JDK tarball (Azul or Oracle) was extracted to `~/zulu-jdk-7.56.0.11`. Then, in order to set all references in the current terminal session to said JDK version, you must update your `PATH`. That can be done in the following manner:

```shell
export JAVA_HOME="~/zulu-jdk-7.56.0.11"
export PATH="$JAVA_HOME/bin:$PATH" # take note of the '/bin'
```
Note that your original `PATH` will remain unaffected in any other terminal window. Another alternative would be to `source` a shell script with the above, as to simplify the process in case you need to use many terminal sessions. If you wish to set your system-wide Java version to this, add the above lines to the end of your `~/.profile` and reboot. Uncomment or remove these rows to revert to how it was. `update-alternatives` to `javac` may also be used in Debian-based systems.

### Windows

On Windows, there's a few complications. Old MCP versions will check the registry key `Software\JavaSoft\Java Development Kit` for the value of `CurrentVersion`, and will use the JDK found under `Software\JavaSoft\Java Development Kit\(value of CurrentVersion)` if it exists. You may have to edit the registry to change this. If there's nothing in the registry, it will then use the version of java from `javac` in `PATH`, and searches various Program Files locations otherwise.

## Old JDK downloads

Here's a table of older JDK download locations:

| Java version    | macOS                                                                                                          | Windows                                                                                                          | Linux                                                                                                           |
| --------------- | -------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| 1.6, OpenJDK    | [SoyLatte](https://landonf.org/static/soylatte/)                                                               | [Azul Zulu](https://www.azul.com/downloads/?version=java-6-lts&os=windows&package=jdk&show-old-builds=true#zulu) | [Azul Zulu](https://www.azul.com/downloads/?version=java-6-lts&os=linux&package=jdk&show-old-builds=true#zulu)  |
| 1.6, Oracle JDK | [Apple Legacy JDK (32 bit)](https://support.apple.com/kb/dl1572)                                               | [Oracle Java 6 Archive](https://www.oracle.com/au/java/technologies/javase-java-archive-javase6-downloads.html)  | [Oracle Java 6 Archive](https://www.oracle.com/au/java/technologies/javase-java-archive-javase6-downloads.html) |
| 1.7, OpenJDK    | [Azul Zulu](https://www.azul.com/downloads/?version=java-7-lts&os=macos&package=jdk&show-old-builds=true#zulu) | [Azul Zulu](https://www.azul.com/downloads/?version=java-7-lts&os=windows&package=jdk&show-old-builds=true#zulu) | [Azul Zulu](https://www.azul.com/downloads/?version=java-7-lts&os=linux&package=jdk&show-old-builds=true#zulu)  |
| 1.7, Oracle JDK | [Oracle Java 7 Archive](https://www.oracle.com/au/java/technologies/javase/javase7-archive-downloads.html)     | [Oracle Java 7 Archive](https://www.oracle.com/au/java/technologies/javase/javase7-archive-downloads.html)       | [Oracle Java 7 Archive](https://www.oracle.com/au/java/technologies/javase/javase7-archive-downloads.html)      |

Note for macOS users: it's generally easier to use Java 7 instead of Java 6 on macOS. The Apple Legacy JDK contains 32 bit components, and may not work on macOS 10.15+. I haven't managed to get SoyLatte working, but it's theoretically possible to use it.

## Why?

Older versions of MCP and Forge take many steps to set up, and sometimes require fixes due to their age. I wrote a guide on [how to install Forge 1.2.5 manually](https://gist.github.com/NeRdTheNed/37b84c7a96a0b24fbc1ca76613f5bae6) some years ago, which was fairly tedious. Using a shell script is hopefully easier than patching files manually.

## License

All scripts are licensed under the BSD Zero Clause License.
