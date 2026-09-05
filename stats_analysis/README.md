# SGP statistics tooling

The balance report and portable statistics snapshots are separate consumers of the same versioned statistics storage.

## Balance report

1. Place `server/world/data/sgp.kits/command_storage.dat` in this folder.
2. Run `python extract.py` from this directory.
3. Open `sgp_balance_report.ipynb` and run all cells.

## Statistics snapshot

Export the completed collector storage with the immutable release identifier of the datapack that produced it:

```powershell
python export_web.py command_storage.dat --datapack-release <release> --output statistics-snapshot.json
```

The deterministic output follows `statistics-snapshot.schema.json` and contains only the collector schema version plus UUID-based players, kills, damage, picks, ability metrics, Elo ratings, damage causes and death positions. It has no website publishing metadata and does not read kit or resource-pack data.

The `SGP-website` repository combines this snapshot with a kit manifest carrying the same datapack release, supplies edition metadata, validates the corresponding resource-pack release and performs the database import. A release mismatch is rejected before a database transaction starts.

```powershell
npm run db:import-edition -- <path-to-statistics-snapshot.json> --kit-manifest data/kit-manifest.json --edition 5
```
