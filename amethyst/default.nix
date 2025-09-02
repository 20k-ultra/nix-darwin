{ config, pkgs, ... }:

{
  home.file.".amethyst.yml".text = ''
    layouts:
      - tall
      - wide
      - column

    # Modifier keys
    mod1:
      - option
      - shift

    mod2:
      - option
      - shift
      - control

    window-margins: true
    window-margin-size: 15
    window-minimum-height: 0
    window-minimum-width: 0
    window-max-count: 0

    mouse-follows-focus: false
    focus-follows-mouse: false
    mouse-swaps-windows: false
    mouse-resizes-windows: true

    floating-is-blacklist: true
    float-small-windows: true
    floating: []

    screen-padding-left: 0
    screen-padding-right: 0
    screen-padding-top: 0
    screen-padding-bottom: 0
    disable-padding-on-builtin-display: true

    # Layout HUD
    enables-layout-hud: true
    enables-layout-hud-on-space-change: false
    debug-layout-info: false

    # Window behavior
    new-windows-to-main: false
    follow-space-thrown-windows: true
    window-resize-step: 5
    restore-layouts-on-launch: true

    # Menu bar
    ignore-menu-bar: false
    hide-menu-bar-icon: false

    # Updates
    use-canary-build: false

    # Layout key bindings
    cycle-layout:
      mod: mod1
      key: space

    cycle-layout-backward:
      mod: mod2
      key: space

    shrink-main:
      mod: mod1
      key: h

    expand-main:
      mod: mod1
      key: l

    increase-main:
      mod: mod1
      key: ","

    decrease-main:
      mod: mod1
      key: "."

    # Focus key bindings
    focus-ccw:
      mod: mod1
      key: j

    focus-cw:
      mod: mod1
      key: k

    focus-main:
      mod: mod1
      key: m

    focus-screen-ccw:
      mod: mod1
      key: p

    focus-screen-cw:
      mod: mod1
      key: n

    # Screen focus shortcuts (1-4)
    focus-screen-1:
      mod: mod1
      key: w

    focus-screen-2:
      mod: mod1
      key: e

    focus-screen-3:
      mod: mod1
      key: r

    focus-screen-4:
      mod: mod1
      key: q

    # Swap key bindings
    swap-ccw:
      mod: mod2
      key: j

    swap-cw:
      mod: mod2
      key: k

    swap-main:
      mod: mod1
      key: enter

    swap-screen-ccw:
      mod: mod2
      key: p

    swap-screen-cw:
      mod: mod2
      key: n

    # Throw to screen (1-4)
    throw-screen-1:
      mod: mod1
      key: "1"

    throw-screen-2:
      mod: mod1
      key: "2"

    throw-screen-3:
      mod: mod1
      key: "3"

    throw-screen-4:
      mod: mod1
      key: "4"

    throw-space-1:
      mod: mod1
      key: "1"

    throw-space-2:
      mod: mod1
      key: "2"

    throw-space-3:
      mod: mod1
      key: "3"

    throw-space-4:
      mod: mod1
      key: "4"

    throw-space-5:
      mod: mod1
      key: "5"

    throw-space-6:
      mod: mod1
      key: "6"

    throw-space-7:
      mod: mod1
      key: "7"

    throw-space-8:
      mod: mod1
      key: "8"

    throw-space-9:
      mod: mod1
      key: "9"

    throw-space-10:
      mod: mod1
      key: "0"

    # Throw to adjacent spaces
    throw-space-left:
      mod: mod2
      key: left

    throw-space-right:
      mod: mod2
      key: right

    # Toggle commands
    toggle-float:
      mod: mod1
      key: t

    toggle-tiling:
      mod: mod2
      key: t

    display-current-layout:
      mod: mod1
      key: i

    toggle-focus-follows-mouse:
      mod: mod2
      key: x

    # Reevaluate and restart
    reevaluate-windows:
      mod: mod1
      key: z

    relaunch-amethyst:
      mod: mod2
      key: z

    select-tall-layout:
      mod: mod1
      key: a

    select-wide-layout:
      mod: mod1
      key: s

    select-fullscreen-layout:
      mod: mod1
      key: d

    select-column-layout:
      mod: mod1
      key: f
  '';
}
