> [!IMPORTANT]
> This repository does not include, distribute, or provide access to any game assets. It only contains the source code to build the recompilation. **You must own a legitimate copy of Resident Evil CODE:Veronica** and extract the required assets from it.

> [!CAUTION]
> This project is a work-in-progress, and while it is in playable state, you might experience bugs and crashes!

# VeronicaRecomp

This is a static recompilation of **Resident Evil CODE:Veronica** for Native PC built through RexGlue-SDK.

<div align="center"><a href="https://x.com/PsxRestore/status/2104731184882413917"><img src="https://raw.githubusercontent.com/psxrestore/CodeVeronicaRecomp/refs/heads/main/preview.jpg" alt="In-Game Screenshots" width="75%"></a><br>(Click thumbnail above to see in-game screenshots)</div>

## Configure & Build

### Prerequisites

- [ReXGlue SDK](https://github.com/rexglue/rexglue-sdk)
- [Visual Studio 2022 Community Edition](https://visualstudio.microsoft.com/vs/community) **with the Desktop development with C++ workload**
- CMake 3.25+
- LLVM/Clang 20+
- Ninja

### Build
#### Download
```
git clone --recursive https://github.com/psxrestore/VeronicaRecomp.git
```
#### Windows
```
cd VeronicaRecomp
cmake --preset win-amd64-release
cmake --build --preset win-amd64-release --target veronicarecomp_codegen
cmake --build --preset win-amd64-release
```
#### Linux **(Untested)**
```
cd VeronicaRecomp
cmake --preset linux-amd64-release
cmake --build --preset linux-amd64-release --target veronicarecomp_codegen
cmake --build --preset linux-amd64-release
```

## Credits
* [RexGlue-SDK](https://github.com/rexglue/rexglue-sdk)
* [Ghidra](https://github.com/NationalSecurityAgency/ghidra)
* [RenderDoc](https://github.com/baldurk/renderdoc)
