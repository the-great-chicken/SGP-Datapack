# SGP statistics tooling

The balance report and website publication are separate consumers of the same versioned statistics storage.

## Balance report

1. Place `server/world/data/sgp.kits/command_storage.dat` in this folder.
2. Run `python extract.py` from this directory.
3. Open `sgp_balance_report.ipynb` and run all cells.

## Website edition export

First generate the current kit manifest from the `SGP-website` repository. That manifest snapshots the kit loadouts and the ability names and descriptions currently declared in `data/sgp.kits/function/initialization.mcfunction`.

Then run the independent web exporter from this directory:

```powershell
python export_web.py command_storage.dat --kit-manifest ..\..\..\..\..\SGP-website\data\kit-manifest.json --edition 5 --name "Cinquième édition" --starts-at 2026-08-01T18:00:00+02:00 --ends-at 2026-08-01T22:00:00+02:00 --datapack-version <version> --resource-pack-version <version>
```

The result defaults to `edition-005.json`. It is a deterministic, versioned bundle containing the exact kit manifest and UUID-based players, kills, damage, picks, ability metrics, Elo ratings, damage causes and death positions for that edition. It does not generate or depend on the balance report.

Import the bundle from the `SGP-website` repository with:

```powershell
npm run db:import-edition -- <path-to-edition-005.json>
```

Reimporting an edition number atomically replaces that edition instead of duplicating its rows.
