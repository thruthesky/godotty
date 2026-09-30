<p align="center">
  <h1 align="center">Godotty</h1>
</p>

<img width="2560" height="1440" alt="godotty_demo" src="https://github.com/user-attachments/assets/4732b973-60a6-4b73-be37-c17a2938806d" />

<p align="center">
  A full-featured yet light-weight terminal emulator for the <a href=https://godotengine.org>Godot Engine</a>, powered by <a href=https://ghostty.org>libghostty</a>.
</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://shieldcn.dev/github/thruthesky/godotty/release.svg?font=jetbrains-mono&mode=dark">
    <img src="https://shieldcn.dev/github/thruthesky/godotty/release.svg?font=jetbrains-mono&mode=light" alt="Version">
  </picture>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://shieldcn.dev/badge/runs%20on-linux-green.svg?logo=linux&font=jetbrains-mono&mode=dark">
    <img src="https://shieldcn.dev/badge/runs%20on-linux-green.svg?logo=linux&font=jetbrains-mono&mode=light" alt="Runs on Linux">
  </picture>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://shieldcn.dev/badge/runs%20on-macos-black.svg?logo=apple&font=jetbrains-mono&mode=dark">
    <img src="https://shieldcn.dev/badge/runs%20on-macos-black.svg?logo=apple&font=jetbrains-mono&mode=light" alt="Runs on macOS">
  </picture>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://shieldcn.dev/badge/runs%20on-windows-blue.svg?font=jetbrains-mono&mode=dark">
    <img src="https://shieldcn.dev/badge/runs%20on-windows-blue.svg?font=jetbrains-mono&mode=light" alt="Runs on Windows">
  </picture>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://shieldcn.dev/github/ingur/godotty/license.svg?font=jetbrains-mono&mode=dark">
    <img src="https://shieldcn.dev/github/ingur/godotty/license.svg?font=jetbrains-mono&mode=light" alt="License">
  </picture>
</p>

## Features

- Full terminal emulation powered by [ghostty](https://ghostty.org)'s VT
  engine ([libghostty-vt](https://github.com/Uzaaft/libghostty-rs))
- Terminals anywhere in the editor: movable docks, a toggleable bottom panel,
  and as a main screen, with multiple terminals visible in an automatic grid
- Selection, clipboard copy / paste (Ctrl+Shift+C / V, Cmd+C / V on macOS),
  drag to reorder tabs
- Tab titles follow the running program, shells open as login shells in
  your project root
- Terminal colors are auto-generated from your editor theme
- JetBrains Mono Nerd Fonts, ligatures, and emojis built in, no setup
- A `Terminal` node for use inside your own editor tools
- Written in Rust as a self-contained GDExtension

## Install — Godotty 애드온만 설치하기

이미 설치된 **Godot 4.7 이상 에디터**와 대상 프로젝트를 사용합니다.
**Godot 에디터를 다시 다운로드할 필요가 없습니다.** 아래 ZIP에는 완성된
애드온과 실행 바이너리가 들어 있으므로 Rust, Zig, Git 설치나 소스 빌드도 필요 없습니다.
Godotty는 프로젝트별 애드온입니다. **새 프로젝트에도 아래 절차로 설치해야 합니다.**

### 1. Godotty 설치 ZIP 다운로드

다음 링크를 눌러 **`godotty-v0.9.7.zip`**을 다운로드합니다.

- **[Godotty 설치 ZIP 바로 다운로드](https://github.com/thruthesky/godotty/releases/download/v0.9.7/godotty-v0.9.7.zip)**
- [릴리스 페이지](https://github.com/thruthesky/godotty/releases/tag/v0.9.7)에서 받으려면
  아래쪽 **Assets**를 펼치고 **`godotty-v0.9.7.zip`**을 선택합니다.

GitHub의 **Code → Download ZIP**, **Source code (zip)**, **Source code (tar.gz)**는
개발용 소스입니다. 설치에 필요한 `bin` 바이너리가 없으므로 위 **설치 ZIP**을 받으세요.
에디터의 AssetLib/Asset Store에 있는 원본 Godotty와 이 저장소의 그리드 버전은
배포 위치가 다르므로, 이 버전은 위 링크로 설치합니다.

같은 설치 ZIP에 아래 환경의 바이너리가 모두 포함되어 있습니다.

| 사용 환경 | ZIP에 포함된 실행 파일 |
| --- | --- |
| macOS Intel / Apple Silicon | `libgodotty.macos.dylib` |
| Windows 10 이상 x86_64 | `libgodotty.windows.x86_64.dll` |
| Linux x86_64 | `libgodotty.linux.x86_64.so` |

### 2. 대상 프로젝트를 닫고 ZIP 압축 해제

1. 대상 Godot 프로젝트에서 작업을 저장하고 **해당 프로젝트의 에디터 창을 종료**합니다.
2. 보통 `다운로드` / `Downloads` 폴더에 있는 `godotty-v0.9.7.zip`을 찾습니다.
3. 운영체제의 압축 해제 기능을 사용합니다.
   - **Windows:** ZIP을 우클릭 → **모두 압축 풀기 / Extract All** → 압축 풀기.
   - **macOS:** ZIP을 더블클릭합니다.
   - **Linux:** 파일 관리자에서 ZIP을 우클릭하고 압축 풀기를 선택합니다.
4. 압축을 푼 위치에서 **`addons/godotty`** 폴더를 찾습니다. 압축 프로그램에 따라
   바깥에 `godotty-v0.9.7` 폴더가 하나 더 생길 수 있습니다. 그 안의 `addons/godotty`를 사용합니다.

`godotty` 폴더 안에는 `godotty.gdextension`, `bin` 폴더와 라이선스 파일들이 있어야 합니다.

### 3. 프로젝트 폴더에 애드온 복사

**프로젝트 루트**는 **`project.godot` 파일이 들어 있는 폴더**입니다.
예를 들어 대상 프로젝트가 `MyGame`이면 다음과 같이 설치합니다.

1. 파일 관리자에서 `MyGame/project.godot`가 있는지 확인합니다.
2. `MyGame` 안에 `addons` 폴더가 없으면 만듭니다. 이미 있으면 그대로 사용합니다.
3. 압축을 푼 위치의 **`addons/godotty` 폴더 전체**를 **`MyGame/addons/` 안으로 복사**합니다.
   다른 애드온 폴더는 그대로 둡니다. 기존 `godotty`를 업데이트하는 경우에는
   프로젝트 바깥에 백업한 뒤 새 `godotty` 폴더로 교체합니다.

설치 후 아래 구조가 되어야 합니다.

```text
MyGame/
├── project.godot
└── addons/
    └── godotty/
        ├── godotty.gdextension
        ├── bin/
        │   ├── libgodotty.macos.dylib
        │   ├── libgodotty.windows.x86_64.dll
        │   └── libgodotty.linux.x86_64.so
        ├── LICENSE
        ├── OFL.txt
        └── FONTS.md
```

`MyGame/addons/addons/godotty` 또는 `MyGame/godotty-v0.9.7/addons/godotty`처럼
추가 폴더가 끼어 있으면 설치 위치가 잘못된 것입니다.
수동 설치에서는 위 폴더를 복사하고, AI에게 설치를 맡길 때는 아래 요청문을 에이전트 채팅에 붙여넣습니다.

### 4. 에디터에서 설치 확인

1. 기존 Godot 에디터로 **대상 프로젝트를 다시 엽니다**. 실행 중이던 창에 파일만
   복사한 경우에는 에디터를 종료했다가 다시 열어야 합니다.
2. 상단에 **Terminal** 화면이 추가되고, 하단 패널에도 **Terminal** 버튼이 나타납니다.
   이 애드온은 GDExtension이 에디터 플러그인을 자동 등록합니다.
   **Project Settings → Plugins에서 활성화할 항목이나 별도 `plugin.cfg`는 필요하지 않습니다.**
3. 하단 **Terminal**을 누릅니다. 첫 터미널이 열리면 **+** 버튼으로 하나 더 추가합니다.
4. 가로 공간이 충분하면 두 터미널이 나란히 표시되고, 더 추가하면 다음 행으로 배치됩니다.
   창이 좁으면 한 칼럼으로 줄어듭니다. 터미널을 클릭해 입력하고 탭의 **×**로 닫을 수 있습니다.

### 설치가 보이지 않을 때

- **Terminal 버튼이 없음:** `project.godot` 옆의
  `addons/godotty/godotty.gdextension` 경로와 `bin` 폴더를 확인하고 에디터를 재시작합니다.
- **라이브러리 파일을 찾을 수 없음:** 개발용 Source code ZIP을 받았는지 확인하고,
  위 **설치 ZIP**으로 `addons/godotty` 전체를 다시 복사합니다.
- **Godot 버전 오류:** 이 애드온에는 이미 설치된 에디터의 버전이 **4.7 이상**이어야 합니다.
- **macOS에서 보안 격리 때문에 라이브러리가 차단됨:** 프로젝트 폴더에서 터미널을 열고
  `xattr -dr com.apple.quarantine addons/godotty`를 실행한 뒤 에디터를 다시 엽니다.

### AI 에이전트에 그대로 복사할 설치 요청문

아래 블록 **전체**를 새 프로젝트에서 작업 중인 AI 코딩 에이전트에 붙여넣으세요.
Godotty 소스 폴더나 이미 다운로드한 ZIP을 미리 준비할 필요가 없습니다.
설치 대상이 현재 작업 중인 Godot 프로젝트라고 명시되어 있어 경로를 바꾸지 않아도 됩니다.

```text
현재 작업 중인 Godot 프로젝트에 Godotty 터미널 애드온 v0.9.7을 실제로 설치해 주세요.
Godot 엔진/에디터는 이미 설치되어 있습니다. Godot 에디터를 다운로드하거나 재설치하지 마세요.
Rust, Zig, Git 설치나 소스 빌드 없이, 아래 완성된 설치 ZIP만 사용하세요.

설치 ZIP 다운로드 주소:
https://github.com/thruthesky/godotty/releases/download/v0.9.7/godotty-v0.9.7.zip
설치 방법 README:
https://github.com/thruthesky/godotty/blob/main/README.md

1. 현재 작업 폴더에서 project.godot가 있는 프로젝트 루트를 확인하세요.
   대상이 없거나 여러 프로젝트 중 어느 것인지 불명확하면 대상 경로를 물어보세요.
   이미 설치된 Godot 에디터가 4.7 이상인지 확인하세요. 버전이 맞지 않으면 알려 주세요.
2. 대상 프로젝트의 에디터가 실행 중이면 작업을 저장하고 종료하도록 안내한 뒤 설치하세요.
   로드 중인 라이브러리를 덮어쓰거나, 사용자의 다른 프로젝트를 임의로 종료하지 마세요.
3. 위 ZIP을 프로젝트 바깥의 임시 폴더로 다운로드하고 압축을 푸세요.
   GitHub Code → Download ZIP이나 Source code ZIP으로 대신 설치하지 마세요.
4. 압축을 푼 위치의 addons/godotty 폴더 전체를 대상 프로젝트 루트의
   addons/godotty로 복사하세요. 대상 addons 폴더가 없으면 만드세요.
   기존 Godotty가 있으면 프로젝트 바깥에 백업하고 교체하세요.
   다른 애드온과 project.godot의 기존 설정은 보존하세요.
5. addons/godotty/godotty.gdextension과 bin 안의 현재 OS용 바이너리가
   실제로 있는지 확인하세요. macOS는 libgodotty.macos.dylib,
   Windows는 libgodotty.windows.x86_64.dll, Linux는 libgodotty.linux.x86_64.so입니다.
   addons/addons/godotty처럼 중첩해서 설치하지 마세요. plugin.cfg도 만들지 마세요.
6. 가능하면 기존 Godot 에디터로 대상 프로젝트를 다시 열고,
   하단 Terminal 버튼과 +로 터미널 두 개가 동시에 표시되는지 확인하세요.
   UI 검증이 불가능하면 파일 검사 결과와 남은 수동 확인을 구분해서 알려 주세요.
7. 실제 설치한 프로젝트 경로, 바이너리 경로, 검증 결과를 알려 주세요.
   설치 방법을 설명하는 것에서 끝내지 말고 파일 다운로드와 복사까지 수행하세요.
```

## Quick Start

- Ctrl+Shift+P and type "terminal" to create one in a dock, the bottom panel, or the main screen.
- Ctrl+` toggles the terminal panel in the bottom panel.
- Add terminals with the **+** button: panes fill columns first and wrap to new
  rows as needed. Resizing the bottom panel or main screen adjusts the column count.
- Click a pane or its tab to focus it; close and drag tabs to remove or reorder panes.
- Ctrl+= / - / 0 (Cmd on macOS) zooms the focused terminal.
- Drag docks anywhere, or float them as windows.
- Settings live in Editor Settings under `godotty`.

## Exports

Godotty never ships in exported games by default.
You can silence the harmless startup logs about the missing extension by adding `addons/godotty/*` to your export preset's exclude filter.
To ship the `Terminal` node in your game, remove the `.editor` tags in `godotty.gdextension`.

## Why?

- I wanted to be able to use all my terminal tools from inside Godot.
- I wanted to build something that feels native to the editor.
- I wanted to use libghostty.

## Building from source — 개발자용 선택 사항

일반 설치에는 위의 완성된 설치 ZIP을 사용합니다. 아래 절차는 소스를 수정하여
직접 빌드하려는 개발자에게만 필요합니다.

1. Godot **4.7 이상**, Rust **1.94 이상**, Zig **0.15.2**를 준비합니다.
   Windows에서는 아래 CI와 같은 `x86_64-pc-windows-gnu` 빌드 환경을 사용하거나,
   이 변경 사항을 포함한 Windows 릴리스 ZIP을 사용합니다.
2. 대상 Godot 프로젝트의 에디터를 종료합니다. 이 애드온은 실행 중인 에디터에서
   바이너리를 교체하거나 핫 리로드할 수 없습니다.
3. Godotty 소스 폴더에서 `cargo build --release`를 실행합니다.
   macOS에서는 먼저 `export SDKROOT="$(xcrun --show-sdk-path)"`를 실행합니다.
   Zig 0.15.2와 최신 Xcode SDK가 호환되지 않으면 macOS 15 SDK를 제공하는
   Xcode/Command Line Tools를 사용합니다. Zig는 `xcrun --sdk macosx --show-sdk-path`로
   SDK를 찾으므로, `SDKROOT`뿐 아니라 이 명령이 선택하는 SDK도 확인합니다.
4. `addons/godotty/bin/` 폴더를 만든 뒤, 빌드 결과를 아래 이름으로 복사합니다.

| 환경 | 빌드 결과 | 애드온 안의 설치 경로 |
| --- | --- | --- |
| macOS | `target/release/libgodotty.dylib` | `addons/godotty/bin/libgodotty.macos.dylib` |
| Linux x86_64 | `target/release/libgodotty.so` | `addons/godotty/bin/libgodotty.linux.x86_64.so` |
| Windows x86_64 GNU | `target/x86_64-pc-windows-gnu/release/godotty.dll` | `addons/godotty/bin/libgodotty.windows.x86_64.dll` |

macOS의 로컬 빌드는 빌드한 CPU 아키텍처의 에디터에서 사용합니다. 다른 Mac에도
배포하려면 CI처럼 arm64/x86_64 빌드를 `lipo`로 합칩니다.
Windows 빌드 명령은 `cargo build --release --target x86_64-pc-windows-gnu`입니다.

5. 소스의 **`addons/godotty` 폴더 전체**를 대상 프로젝트의
   **`project.godot` 옆 `addons/godotty`**로 복사합니다. `.gdextension`,
   `bin` 폴더의 바이너리, 라이선스 파일을 함께 복사해야 합니다.
6. 대상 프로젝트를 Godot 에디터로 다시 엽니다. GDExtension이 에디터 플러그인을
   자동 등록하므로 별도 `plugin.cfg` 작성이나 플러그인 활성화는 필요하지 않습니다.
7. 상단 **Terminal** 화면 또는 바텀 패널의 **Terminal**을 열고 **+**로
   터미널을 두 개 이상 추가합니다. 충분한 가로 공간에서는 여러 칼럼이 동시에
   보이고, 폭을 줄이면 다음 행으로 이동합니다. 탭·터미널 클릭, 탭 닫기와
   순서 변경도 확인합니다.

[devenv](https://devenv.sh)를 사용하는 Linux 환경에서는 저장소의 `package` 명령으로
설치 ZIP을 만들 수 있습니다.

## Roadmap

- Kitty image protocol support, still need to hook it up.

## Credits

- [Godot](https://godotengine.org) for the engine
- [ghostty](https://ghostty.org) for `libghostty-vt`
- [libghostty-rs](https://github.com/Uzaaft/libghostty-rs) for the Rust bindings
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/) for the bundled fonts

## License

[MIT](LICENSE), Bundled fonts are OFL-1.1, see
[addons/godotty/FONTS.md](addons/godotty/FONTS.md).
