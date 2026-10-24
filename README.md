# Centrum logistyczne biżuterii i zegarków luksusowych

Wieloprocesowa symulacja centrum logistycznego w Adzie.

## Wybrane moduły

- Moduły podstawowe: 1 (dostawy i stanowisko rozładunkowe), 2 (roboty transportowe), 3 (magazyn)
- Moduły dodatkowe: D (awarie robotów), F (serwis naprawczy), G (kontroler / monitor centrum)

## Uruchomienie

Wymagany kompilator GNAT (GNAT Studio albo MSYS2: `pacman -S mingw-w64-ucrt-x86_64-gcc-ada`).

```bash
mkdir obj
```

```bash
gnatmake -D obj -aIsrc src/main.adb -o main.exe
```

```bash
./main.exe
```

W GNAT Studio: otwórz `projekt.gpr` i uruchom `main`.
