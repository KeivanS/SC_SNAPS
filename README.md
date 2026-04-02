# SC-Snaps GUI

A browser-based graphical interface for the `sc_snaps.x` supercell snapshot
generator. Runs locally as a Flask web app — no internet connection required.

---

## What it does

`sc_snaps.x` generates thermally-displaced supercell snapshots for use in
phonon calculations. This GUI lets you:

- Edit the three input files (`cell.inp`, `snaps.inp`, `supercell.inp`)
  directly in the browser with format hints (a default will first be uploded)
- Save edits to disk explicitly before running
- Run `sc_snaps.x` and watch the live output stream
- Browse generated `poscar_*` files and the snapshots.xyz file
- Click on any generated poscar or snapshots.xyz to visualize the generated structures using Jmol — all with one click
- Vesta or similar visyualization softwares are also possible; 
  just replace the jmol path in the configuration section

---

## Requirements

| Requirement | Notes |
|-------------|-------|
| Python ≥ 3.8 | |
| [Flask](https://flask.palletsprojects.com/) | `pip install flask` |
| `sc_snaps.x` | The snapshot generator executable |
| `poscar2xyz.py` | Converts POSCAR-format files to XYZ (optional) |
| [Jmol](https://jmol.sourceforge.net/) | Structure visualizer (optional) |

```bash
pip install flask
```

---

## Installation & first-time setup

```bash
git clone https://github.com/YOUR_USERNAME/sc-snaps-gui.git
cd sc-snaps-gui
make run            # opens http://localhost:5050
```

Or without make:
```bash
python3 sc-snaps-gui.py
```

---

## Configuration — `site.env`

`site.env` is **never committed** (gitignored). Copy from the template and
edit for your system:

```makefile
PYTHON     = python3
SC_SNAPS_X = ~/BIN/sc_snaps.x
# VISUALIZER = ~/BIN/jmol           # Jmol shell script or .app bundle
# POSCAR2XYZ = ~/BIN/poscar2xyz.py  # POSCAR → XYZ converter
```

All paths set here become the default values shown in the browser on startup.
They can be overridden at any time in the browser without restarting.

---

## Input files

### `cell.inp` — primitive cell
```
1 1 1   90 90 90          # conventional cell: a b c  α β γ
 0 0.5 0.5, 0.5 0 0.5, 0.5 0.5 0   # primitive vectors (in conventional units)
4.247                     # lattice parameter scale (Å)
2                         # number of atom types
1 1                       # number of atoms of each type
24.31  16.00              # atomic masses
Mg O                      # element names
  0 0 0                   # reduced coordinates (conventional lattice)
  0.5 0.5 0.5
```

### `snaps.inp` — snapshot parameters
```
400    # average phonon frequency (cm⁻¹)
300    # temperature (K)
51 1   # number of snapshots  supercell_type (default=1)
```

### `supercell.inp` — supercell dimensions
```
3 0 0
0 3 0
0 0 3
```
3×3 integer matrix: supercell vectors in terms of the primitive cell vectors.
A diagonal matrix gives an n×n×n supercell.

---

## Output

After running, the working directory contains:

| File | Description |
|------|-------------|
| `poscar_000` | Unshifted reference supercell (POSCAR format) |
| `poscar_001` … `poscar_N` | Thermally displaced snapshots |
| `poscar_j.xyz` | XYZ-format versions (created on demand by clicking "Convert & open in Jmol") |

---

## Workflow

1. **Set working directory** — type a path (new or existing) and optionally
   click **Load existing files** to populate the text areas from disk
2. **Edit** the three input files in the text areas
3. Click **💾 Save input files** to write edits to disk
4. Click **▶ Run sc_snaps.x** — files are saved and the job starts;
   live output streams in the log box
5. After completion, generated snapshots (poscar_j) appear as grey chips:
6. Click any chip to view its content inline
7. Click **👁 Convert & open in Jmol** (POSCAR) or **👁 Open in Jmol** (XYZ)
   to launch the visualizer

---

## File structure

```
sc-snaps-gui/
├── sc-snaps-gui.py      # Flask server + single-page browser app
├── Makefile             # make setup / make run
└── README.md
```

---

## License

MIT — see [LICENSE](LICENSE) for details.
