# YashJodon-Dots Architecture

> Project architecture and development rules.

---

# Philosophy

YashJodon-Dots is designed as a modular, maintainable and production-quality
Hyprland customization framework.

Goals:

- Simple
- Modular
- Testable
- Predictable
- Safe
- Easy to maintain

---

# Project Layout

```
YashJodon-Dots/

assets/
docs/
fastfetch/
hypr/
hyprlock/
kitty/
rofi/
scripts/
wallpapers/
waybar/

install.sh
```

---

# Installer Architecture

```
install.sh
        │
        ▼
bootstrap.sh
        │
        ▼
utils.sh
        │
        ├─────────────┐
        │             │
        ▼             ▼

colors      logger

system       ui

files        cleanup

timer
```

No module should directly depend on another module.

Every module is loaded only through:

```
bootstrap.sh
```

---

# Layer Design

Layer 1

Core Utilities

- colors
- logger
- system
- ui
- files
- cleanup
- timer

These modules contain reusable helper functions.

---

Layer 2

Installer Components

- distro
- dependencies
- backup
- packages
- configs
- wallpaper
- fonts
- finish

These modules perform installation tasks.

---

Layer 3

Desktop Components

- Hyprland
- Waybar
- Rofi
- Hyprlock
- Wlogout
- Fastfetch

---

# Naming Convention

Public functions

```
yjd_function_name()
```

Private functions

```
_yjd_function_name()
```

Constants

```
YJD_CONSTANT
```

Variables

```
snake_case
```

---

# Return Codes

0

Success

1

Expected failure

Example:

Missing package

2

Internal error

Unexpected condition

Never exit from utility modules.

Only install.sh may terminate the installer.

---

# Logging

All messages go through:

```
yjd_log_info()

yjd_log_success()

yjd_log_warning()

yjd_log_error()
```

No direct printf or echo for status messages.

---

# User Interface

Only ui.sh prints:

Headers

Sections

Progress

Questions

Dialogs

Other modules never print UI directly.

---

# Error Handling

Use

```
return
```

inside libraries.

Never call

```
exit
```

inside utility modules.

Installer decides how to continue.

---

# Coding Rules

Always

- Quote variables

```
"$HOME"
```

Use

```
local
```

inside functions.

Always

```
set -Eeuo pipefail
```

for executable scripts.

Never

- eval
- unquoted variables
- duplicate code
- global mutable variables

---

# Testing

Every module must have

```
test_<module>.sh
```

Examples

```
test_colors.sh

test_logger.sh

test_system.sh
```

All tests are executed using

```
run_all.sh
```

---

# Documentation Rule

Every public function must contain

- Purpose
- Parameters
- Return value

---

# Quality Gate

Every file must pass

- bash -n

- shellcheck -x

- shfmt

- local tests

before commit.

---

# Project Principle

Write code once.

Maintain it forever.

Never sacrifice architecture for speed.