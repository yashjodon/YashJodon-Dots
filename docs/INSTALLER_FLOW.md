# YashJodon-Dots Installer Flow

> Official installer execution flow.
>
> This document defines the exact order in which the installer executes.
> Every installer module must follow this document.

---

# Philosophy

The installer should only coordinate tasks.

It must never contain installation logic.

Each responsibility belongs to its own module.

Example:

install.sh
    ↓
packages.sh

NOT

install.sh
    ↓
pacman -S ...

---

# Installer Overview

```
Start
 │
 ▼
Validate Environment
 │
 ▼
Load Framework
 │
 ▼
Initialize Logger
 │
 ▼
Display Banner
 │
 ▼
Verify Dependencies
 │
 ▼
Detect Linux Distribution
 │
 ▼
Display Installation Plan
 │
 ▼
Ask User Confirmation
 │
 ▼
Create Backup
 │
 ▼
Install Required Packages
 │
 ▼
Install Configurations
 │
 ▼
Install Wallpapers
 │
 ▼
Configure Desktop
 │
 ▼
Reload Services
 │
 ▼
Run Cleanup
 │
 ▼
Display Summary
 │
 ▼
Finish
```

---

# Stage 1

## Validate Environment

Responsibilities

- Verify Bash version
- Verify supported distribution
- Verify internet connection
- Verify required commands
- Verify write permissions

If any check fails

Installer stops.

---

# Stage 2

## Load Framework

Responsibilities

Load

- bootstrap.sh
- utility modules

No installation happens here.

---

# Stage 3

## Initialize Logger

Responsibilities

- Create log directory
- Create log file
- Start installation timer
- Print installation information

---

# Stage 4

## Display Banner

Responsibilities

Show

- Project name
- Version
- Author
- Current distribution

---

# Stage 5

## Dependency Verification

Required commands

- git
- curl
- wget
- sudo
- bash

Missing dependencies are reported.

Nothing is installed yet.

---

# Stage 6

## Detect Distribution

Supported

- Arch Linux
- CachyOS
- EndeavourOS
- Manjaro

Future

- Fedora
- Debian
- Ubuntu

---

# Stage 7

## Installation Plan

Show

- Distribution
- Packages
- Configuration count
- Estimated installation time

---

# Stage 8

## Confirmation

Example

Continue installation?

[y/N]

Installer exits if user selects No.

---

# Stage 9

## Backup

Backup

- Hyprland
- Waybar
- Kitty
- Rofi
- Hyprlock
- Wallpapers

Every backup receives a timestamp.

Example

```
backup-2026-07-04-145200/
```

---

# Stage 10

## Package Installation

Responsibilities

Install

- Fonts
- Required packages
- Utilities

No configuration files here.

---

# Stage 11

## Configuration Installation

Copy

- Hyprland
- Waybar
- Kitty
- Rofi
- Hyprlock

---

# Stage 12

## Wallpaper Installation

Install

- Wallpapers
- Cache
- Theme assets

---

# Stage 13

## Desktop Configuration

Reload

- Hyprland
- Waybar
- Theme cache

Generate

- Fastfetch config

---

# Stage 14

## Cleanup

Remove

- Temporary files
- Download cache

Preserve

- Log files

---

# Stage 15

## Summary

Display

- Installed packages
- Installed configs
- Backup location
- Installation time

Example

Installation completed successfully.

Time

08m 34s

---

# Stage 16

## Finish

Thank the user.

Display useful commands.

Example

Hyprland

```
Super + Q
```

Reload

```
hyprctl reload
```

---

# Error Handling

Utility modules

Never call

```
exit
```

They always

```
return
```

Only

install.sh

may terminate the installer.

---

# Logging

Every stage must write to

installer.log

Example

```
[INFO]

Checking Internet

[SUCCESS]

Internet Available

[INFO]

Installing Packages

[SUCCESS]

Finished
```

---

# Testing

Every stage must have

- unit tests
- integration tests

No stage may be merged unless tests pass.

---

# Future Features

- Dry Run Mode
- Verbose Mode
- Rollback
- Resume Installation
- Offline Installation
- Automatic Updates

---

# Design Principle

The installer coordinates.

Modules perform work.

No business logic belongs inside install.sh.