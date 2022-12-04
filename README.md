# c128lib/chipset
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CircleCI](https://circleci.com/gh/c128lib/chipset/tree/master.svg?style=shield)](https://circleci.com/gh/c128lib/chipset/tree/master)
[![Latest release](https://img.shields.io/github/v/release/c128lib/chipset.svg)](https://github.com/c128lib/chipset/releases)

## Usage

If you need only labels, use:

```
#import "./lib/mmu.asm"
```

If you need both labels and macros, use:

```
#import "./lib/mmu-global.asm"
```

Not all files have *_global.asm.

Labels are available by prefixing library name (c128lib) and namespace (for example, Mmu):

```
sta c128lib.Mmu.LOAD_CONFIGURATION
```

## Components

### Cia

https://en.wikipedia.org/wiki/MOS_Technology_CIA

Namespace **Cia**

Labels $DC00-$DC0F (Cia1) and $DD00-$DD0F (Cia2).

#### Memory references
* https://c128lib.github.io/Reference/Cia
* https://c128lib.github.io/Reference/DC00
* https://c128lib.github.io/Reference/DD00

### Mmu

Namespace **Mmu**

Labels $D500-$D50B and $FF00-$FF04

#### Memory references
* https://c128lib.github.io/Reference/Mmu
* https://c128lib.github.io/Reference/D500

### Mos8502

https://en.wikipedia.org/wiki/MOS_Technology_8502

Namespace **Mos8502**

Labels $00-$01

#### Memory references
TBD

### Sid

https://en.wikipedia.org/wiki/MOS_Technology_6581

Namespace **Sid**

Labels $D400-$D41C

#### Memory references
* https://c128lib.github.io/Reference/Sid
* https://c128lib.github.io/Reference/D400

### Vdc

https://en.wikipedia.org/wiki/MOS_Technology_8563

Namespace **Vdc**

Labels $D600-$D601 and internal register $00-$24

#### Memory references
* https://c128lib.github.io/Reference/Vdc
* https://c128lib.github.io/Reference/D600

### Vic-IIe

https://en.wikipedia.org/wiki/MOS_Technology_VIC-II

Namespace **Vic**

Labels $D000-$D030

#### Memory references
* https://c128lib.github.io/Reference/Vic
* https://c128lib.github.io/Reference/D000
