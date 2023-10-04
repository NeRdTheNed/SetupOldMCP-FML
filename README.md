# Setup old MCP / FML

> Shell scripts to automatically set up old versions of MCP and FML

Scripts:

-   setupFML1.2.5.sh: downloads and sets up a FML 1.2.5 environment.  
    Requirements: curl, unzip, dos2unix if not on Windows.  
    Python 2 and Java are required for MCP setup (JDK 6 recommended, JDK 7 works as well).

## Using specific JDK versions

On Linux or macOS, setting the version of Java used is generally very simple:

```shell
export JAVA_HOME=/path/to/java/home
```

On Windows, there's a few complications. Old MCP versions will check the registry key `Software\JavaSoft\Java Development Kit` for the value of `CurrentVersion`, and will use the JDK found under `Software\JavaSoft\Java Development Kit\(value of CurrentVersion)` if it exists. You may have to edit the registry to change this. If there's nothing in the registry, it will then use the version of java from `javac` in `PATH`, and searches various Program Files locations otherwise.

## Old JDK downloads

Here's a table of older JDK download locations:

| Java version    | macOS                                                                                                          | Windows                                                                                                          | Linux                                                                                                           |
| --------------- | -------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| 1.6, OpenJDK    | N/A                                                                                                            | [Azul Zulu](https://www.azul.com/downloads/?version=java-6-lts&os=windows&package=jdk&show-old-builds=true#zulu) | [Azul Zulu](https://www.azul.com/downloads/?version=java-6-lts&os=linux&package=jdk&show-old-builds=true#zulu)  |
| 1.6, Oracle JDK | [Apple Legacy JDK (32 bit)](https://support.apple.com/kb/dl1572)                                               | [Oracle Java 6 Archive](https://www.oracle.com/au/java/technologies/javase-java-archive-javase6-downloads.html)  | [Oracle Java 6 Archive](https://www.oracle.com/au/java/technologies/javase-java-archive-javase6-downloads.html) |
| 1.7, OpenJDK    | [Azul Zulu](https://www.azul.com/downloads/?version=java-7-lts&os=macos&package=jdk&show-old-builds=true#zulu) | [Azul Zulu](https://www.azul.com/downloads/?version=java-7-lts&os=windows&package=jdk&show-old-builds=true#zulu) | [Azul Zulu](https://www.azul.com/downloads/?version=java-7-lts&os=linux&package=jdk&show-old-builds=true#zulu)  |
| 1.7, Oracle JDK | [Oracle Java 7 Archive](https://www.oracle.com/au/java/technologies/javase/javase7-archive-downloads.html)     | [Oracle Java 7 Archive](https://www.oracle.com/au/java/technologies/javase/javase7-archive-downloads.html)       | [Oracle Java 7 Archive](https://www.oracle.com/au/java/technologies/javase/javase7-archive-downloads.html)      |

Note for macOS users: the Apple Legacy JDK contains 32 bit components, and may not work on macOS 10.15+.

## Why?

Older versions of MCP and Forge take many steps to set up, and sometimes require fixes due to their age. I wrote a guide on [how to install Forge 1.2.5 manually](https://gist.github.com/NeRdTheNed/37b84c7a96a0b24fbc1ca76613f5bae6) some years ago, which was fairly tedious. Using a shell script is hopefully easier than patching files manually.

## License

All scripts are licensed under the BSD Zero Clause License.
