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

## Install

Requires Godot 4.7+ on Linux, macOS, or Windows 10+.

- **Asset Library**: search for "Godotty" in the editor's AssetLib tab for the
  upstream addon. For this fork's grid version, use the manual download below.
- **Manual**: grab the zip from the
  [releases page](https://github.com/thruthesky/godotty/releases) and extract it
  into your project root.

> [!NOTE]
> On macOS, if Gatekeeper blocks the library,
> clear the quarantine flag: 
> `xattr -dr com.apple.quarantine addons/godotty`.

### 현재 소스의 그리드 버전 설치

빌드 없이 설치하려면 이 저장소의 [v0.9.7 이상 릴리스](https://github.com/thruthesky/godotty/releases)에서
`godotty-v*.zip`을 받아 프로젝트 루트에 압축을 풀고 에디터를 다시 엽니다.
아래는 현재 소스를 직접 빌드해서 설치하는 방법입니다.

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

### AI 에이전트에 복사할 설치 요청문

아래 코드 블록을 복사하여 코딩 에이전트에 붙여넣으세요.
처음 두 줄의 경로를 실제 소스 폴더와 대상 Godot 프로젝트 폴더로 바꿉니다.

```text
Godotty 소스 폴더: /path/to/godotty
대상 Godot 프로젝트 폴더: /path/to/my-godot-project

현재 Godotty 소스의 다중 터미널 그리드 버전을 대상 프로젝트에 설치해 주세요.
소스 README.md의 '현재 소스의 그리드 버전 설치' 절을 읽고 실제 설치까지 수행하세요.

1. 대상 폴더에 project.godot가 있는지, Godot가 4.7 이상인지 확인하세요.
   경로가 불명확하면 추측해서 다른 프로젝트에 설치하지 말고 물어보세요.
2. 대상 프로젝트의 Godot 에디터가 열려 있으면 저장하고 종료하도록 안내하세요.
   실행 중인 에디터에 로드된 라이브러리를 덮어쓰지 마세요.
3. 현재 OS/CPU에 맞게 이 소스를 빌드하세요. Rust 1.94 이상과 Zig 0.15.2가
   필요합니다. macOS에서는 호환되는 SDKROOT와 Zig가 xcrun으로 선택하는 SDK를 확인하세요.
   그리드 변경을 포함하지 않은 과거 릴리스로 대신 설치하지 마세요.
4. README의 표에 따라 빌드 결과를 소스 addons/godotty/bin에 배치하세요.
   기존 설치가 있으면 프로젝트 바깥에 백업한 뒤 addons/godotty 폴더 전체를
   대상 프로젝트의 project.godot 옆 addons/godotty에 복사하세요.
   다른 애드온과 project.godot의 기존 설정은 보존하세요.
5. .gdextension이 가리키는 바이너리가 실제로 존재하는지 확인하세요.
   plugin.cfg를 만들지 마세요. 에디터 플러그인은 GDExtension이 자동 등록합니다.
6. 가능하면 대상 프로젝트의 에디터를 열어 로딩 오류를 확인하고, Terminal에서
   터미널 두 개 추가, 동시 표시, 크기 변경, 포커스 전환, 닫기를 검증하세요.
   UI 검증이 불가능하면 수행한 검사와 남은 수동 확인을 구분해 알려 주세요.
7. 설치한 프로젝트 경로와 바이너리 경로, 검증 결과를 알려 주세요.
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

## Building from source

Requirements: Rust (stable), Zig 0.15.2, or
[devenv](https://devenv.sh) with the included configuration.

```bash
cargo build --release   # produces target/release/libgodotty.so
package                 # devenv script: assembles dist/godotty-v*.zip
```

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
