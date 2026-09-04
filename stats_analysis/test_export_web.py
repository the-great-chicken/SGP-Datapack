from __future__ import annotations

import unittest
from pathlib import Path
from tempfile import TemporaryDirectory

import nbtlib
import pandas as pd

from export_web import (
    WebExportError,
    build_bundle,
    extract_statistics,
    render_bundle,
)


PLAYER_ONE = "11111111-1111-4111-8111-111111111111"
PLAYER_TWO = "22222222-2222-4222-8222-222222222222"


class WebExportTests(unittest.TestCase):
    def test_extracts_schema_7_command_storage_without_the_report(self) -> None:
        with TemporaryDirectory() as directory:
            storage_path = Path(directory) / "command_storage.dat"
            nbtlib.File(
                nbtlib.parse_nbt(make_command_storage_snbt())
            ).save(storage_path)

            schema_version, statistics = extract_statistics(storage_path)
            bundle = self.build_test_bundle(statistics)

        self.assertEqual(schema_version, 7)
        self.assertEqual(bundle["players"][0]["uuid"], PLAYER_ONE)
        self.assertEqual(bundle["kills"][0]["count"], 1)
        self.assertEqual(bundle["abilityMetrics"][0]["value"], 3.0)
        self.assertEqual(bundle["elo"]["ratings"][0]["rating"], 1012.5)

    def test_builds_uuid_based_deterministic_bundle(self) -> None:
        bundle = self.build_test_bundle()

        self.assertEqual(bundle["schemaVersion"], 1)
        self.assertEqual(bundle["edition"]["number"], 5)
        self.assertEqual(bundle["kills"][0]["killerUuid"], PLAYER_ONE)
        self.assertEqual(bundle["kills"][0]["victimUuid"], PLAYER_TWO)
        self.assertIsNone(bundle["damageReceived"][0]["sourceUuid"])
        self.assertEqual(bundle["abilityMetricDefinitions"][0]["name"], "Uses")
        self.assertEqual(bundle["elo"]["ratings"][0]["ratedEncounters"], 4)
        self.assertEqual(render_bundle(bundle), render_bundle(self.build_test_bundle()))

    def test_rejects_unknown_player_ids(self) -> None:
        statistics = make_statistics()
        statistics["picks"] = pd.DataFrame(
            [{"id": "99", "kit_id": 0, "total_time": 20, "nbr_picks": 1}]
        )

        with self.assertRaisesRegex(WebExportError, "unknown sgp.id 99"):
            self.build_test_bundle(statistics)

    def test_rejects_ability_metadata_from_another_kit_snapshot(self) -> None:
        manifest = make_kit_manifest()
        manifest["kits"][0]["ability"]["path"] = "different"

        with self.assertRaisesRegex(WebExportError, "does not match"):
            self.build_test_bundle(kit_manifest=manifest)

    def build_test_bundle(
        self,
        statistics: dict[str, pd.DataFrame] | None = None,
        kit_manifest: dict | None = None,
    ) -> dict:
        return build_bundle(
            edition_number=5,
            edition_name="Cinquième édition",
            status="published",
            starts_at="2026-08-01T18:00:00+02:00",
            ends_at="2026-08-01T22:00:00+02:00",
            published_at="2026-08-02T10:00:00Z",
            datapack_version="v5",
            resource_pack_version="v5",
            statistics_schema_version=7,
            kit_manifest=kit_manifest or make_kit_manifest(),
            statistics=statistics or make_statistics(),
        )


def make_kit_manifest() -> dict:
    return {
        "$schema": "../schemas/kit-manifest.schema.json",
        "schemaVersion": 2,
        "minecraftVersion": "26.1",
        "dataPack": {"id": "sgp", "minFormat": 101.1, "maxFormat": 101.1},
        "kits": [
            {
                "id": 0,
                "key": "pigeon",
                "name": "Pigeon",
                "color": "dark_gray",
                "icon": "P",
                "ability": {
                    "path": "pecking",
                    "name": "Picorage",
                    "description": "Attaque continuellement la cible.",
                    "activationKeybind": "key.drop",
                    "descriptionComponents": [{"text": "Attaque continuellement la cible."}],
                },
                "function": "sgp.kits:collection/pigeon/items",
                "operations": [],
            }
        ],
    }


def make_statistics() -> dict[str, pd.DataFrame]:
    return {
        "players": pd.DataFrame(
            [
                {"id": "1", "uuid": PLAYER_ONE, "nickname": "Alpha"},
                {"id": "2", "uuid": PLAYER_TWO, "nickname": "Bravo"},
            ]
        ),
        "kills": pd.DataFrame(
            [
                {
                    "id_killer": "1",
                    "kit_id_killer": 0,
                    "id_victim": "2",
                    "kit_id_victim": 0,
                    "cause_id": 1,
                    "kills": 2,
                }
            ]
        ),
        "damage_received": pd.DataFrame(
            [
                {
                    "id_target": "2",
                    "kit_id_target": 0,
                    "id_source": "-1",
                    "kit_id_source": -1,
                    "cause_id": 18,
                    "damage_received": 3.5,
                }
            ]
        ),
        "picks": pd.DataFrame(
            [{"id": "1", "kit_id": 0, "total_time": 1200, "nbr_picks": 2}]
        ),
        "abilities": pd.DataFrame(
            [
                {
                    "id": "1",
                    "kit_id": 0,
                    "ability_path": "pecking",
                    "metric_id": "uses",
                    "value": 3.0,
                }
            ]
        ),
        "ability_metadata": pd.DataFrame(
            [
                {
                    "kit_id": 0,
                    "ability_path": "pecking",
                    "metric_id": "uses",
                    "metric_name": "Uses",
                    "description": "Valid starts.",
                    "cooldown_ticks": 400,
                    "duration_ticks": pd.NA,
                    "settings_json": "{}",
                    "stored_unit": "count",
                    "display_unit": "uses",
                    "display_scale": 1.0,
                    "source_type": "ability_field",
                    "source_field": "uses",
                    "source_kit_id": pd.NA,
                    "source_cause_ids": None,
                    "source_exclude_self": pd.NA,
                }
            ]
        ),
        "damage_causes": pd.DataFrame(
            [{"cause_id": 1, "cause_name": "player_attack"}]
        ),
        "death_position_metadata": pd.DataFrame(
            [
                {
                    "stored_unit": "block_tenths",
                    "display_unit": "blocks",
                    "display_scale": 0.1,
                    "quantization": "floor",
                    "position_reference": "feet",
                }
            ]
        ),
        "death_positions": pd.DataFrame(
            [{"dimension": "minecraft:overworld", "x": 1.0, "y": 64.0, "z": 2.0, "deaths": 1}]
        ),
        "elo_metadata": pd.DataFrame(
            [
                {
                    "initial_rating": 1000.0,
                    "k_factor": 80.0,
                    "rating_divisor": 1050.0,
                    "metric_id": "rated_encounters",
                    "metric_name": "Rated encounters",
                    "metric_description": "Rated encounters.",
                    "stored_unit": "count",
                    "display_unit": "encounters",
                    "display_scale": 1.0,
                },
                {
                    "initial_rating": 1000.0,
                    "k_factor": 80.0,
                    "rating_divisor": 1050.0,
                    "metric_id": "rating",
                    "metric_name": "Elo rating",
                    "metric_description": "Current rating.",
                    "stored_unit": "centi_elo",
                    "display_unit": "elo",
                    "display_scale": 0.01,
                },
            ]
        ),
        "elo_ratings": pd.DataFrame(
            [{"id": "1", "rating": 1012.5, "rated_encounters": 4}]
        ),
    }


def make_command_storage_snbt() -> str:
    uuid_parts = []
    compact_uuid = PLAYER_ONE.replace("-", "")
    for offset in range(0, 32, 8):
        part = int(compact_uuid[offset : offset + 8], 16)
        uuid_parts.append(part if part < 2**31 else part - 2**32)

    return """{
        data:{contents:{stats:{
            schema_version:7,
            players:{"1":{uuid:[I;%s],nickname:"Alpha"}},
            kits_dict:{"1":{"0":{
                abilities:{pecking:{uses:3}},
                kills:{"1":{"0":{"1":1}}},
                damage_received:{},
                pick:{total_time:1200,nbr_picks:1}
            }}},
            ability_metadata:{"0":{pecking:{
                cooldown:400,
                metrics:{uses:{
                    name:"Uses",
                    description:"Valid starts.",
                    stored_unit:"count",
                    display_unit:"uses",
                    display_scale:1.0d,
                    source:{type:"ability_field",field:"uses"}
                }}
            }}},
            damage_cause_names:{"1":"player_attack"},
            death_position_metadata:{
                stored_unit:"block_tenths",
                display_unit:"blocks",
                display_scale:0.1d,
                quantization:"floor",
                position_reference:"feet"
            },
            death_positions:{},
            elo_metadata:{
                initial_rating:1000.0d,
                k_factor:80.0d,
                rating_divisor:1050.0d,
                metrics:{
                    rating:{
                        name:"Elo rating",
                        description:"Current rating.",
                        stored_unit:"centi_elo",
                        display_unit:"elo",
                        display_scale:0.01d
                    },
                    rated_encounters:{
                        name:"Rated encounters",
                        description:"Rated encounters.",
                        stored_unit:"count",
                        display_unit:"encounters",
                        display_scale:1.0d
                    }
                }
            },
            elo_ratings:{"1":{rating:101250,rated_encounters:4}}
        }}}
    }""" % ",".join(str(part) for part in uuid_parts)


if __name__ == "__main__":
    unittest.main()
