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

## Why?

Older versions of MCP and Forge take many steps to set up, and sometimes require fixes due to their age. Using a shell script is hopefully easier than patching files manually.

## License

All scripts are licensed under the BSD Zero Clause License.
