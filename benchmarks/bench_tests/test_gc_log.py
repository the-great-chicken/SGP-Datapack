from datetime import datetime, timedelta, timezone
from pathlib import Path
import tempfile
import unittest

import bench

TZ = timezone(timedelta(hours=2))
LOG = """[2026-09-21T08:13:00.000+0200][1.000s] Using G1
[2026-09-21T08:13:05.000+0200][6.000s] GC(0) Pause Young (Normal) (G1 Evacuation Pause) 300M->200M(6144M) 12.500ms
[2026-09-21T08:13:07.000+0200][8.000s] GC(1) Concurrent Mark Cycle
[2026-09-21T08:13:08.000+0200][9.000s] GC(2) Pause Young (Concurrent Start) (G1 Humongous Allocation) 1024M->900M(6144M) 20.000ms
[2026-09-21T08:13:09.500+0200][10.500s] GC(3) Pause Full (G1 Compaction Pause) 6000M->5900M(6144M) 1500.000ms
[2026-09-21T08:13:20.000+0200][21.000s] GC(4) Pause Young (Normal) (G1 Evacuation Pause) 512000K->100M(6G) 5.000ms
"""


class GcLogTests(unittest.TestCase):
    def test_parses_pauses_and_summarizes_the_capture_window(self):
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary) / 'gc.log'
            path.write_text(LOG, encoding='utf-8')
            pauses = bench.parse_gc_log(path)
        self.assertEqual([pause.kind for pause in pauses], [
            'Young (Normal) (G1 Evacuation Pause)',
            'Young (Concurrent Start) (G1 Humongous Allocation)',
            'Full (G1 Compaction Pause)',
            'Young (Normal) (G1 Evacuation Pause)',
        ])
        self.assertEqual(pauses[0].at, datetime(2026, 9, 21, 8, 13, 5, tzinfo=TZ))
        self.assertAlmostEqual(pauses[3].before_mb, 500.0)
        self.assertAlmostEqual(pauses[3].capacity_mb, 6144.0)

        summary = bench.summarize_gc(
            pauses, datetime(2026, 9, 21, 8, 13, 6, tzinfo=TZ), datetime(2026, 9, 21, 8, 13, 10, tzinfo=TZ), 200
        )
        self.assertEqual(summary['pauses'], 2)
        self.assertEqual(summary['full_pauses'], 1)
        self.assertAlmostEqual(summary['total_ms'], 1520.0)
        self.assertAlmostEqual(summary['max_ms'], 1500.0)
        self.assertAlmostEqual(summary['ms_per_tick'], 7.6)
        self.assertAlmostEqual(summary['heap_after_mb'], 5900.0)
        self.assertAlmostEqual(summary['heap_capacity_mb'], 6144.0)

    def test_window_without_pauses_still_reports_the_last_known_heap(self):
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary) / 'gc.log'
            path.write_text(LOG, encoding='utf-8')
            pauses = bench.parse_gc_log(path)
        summary = bench.summarize_gc(
            pauses, datetime(2026, 9, 21, 8, 13, 11, tzinfo=TZ), datetime(2026, 9, 21, 8, 13, 15, tzinfo=TZ), 0
        )
        self.assertEqual(summary['pauses'], 0)
        self.assertEqual(summary['total_ms'], 0.0)
        self.assertIsNone(summary['ms_per_tick'])
        self.assertAlmostEqual(summary['heap_after_mb'], 5900.0)

    def test_missing_log_is_empty(self):
        self.assertEqual(bench.parse_gc_log(Path('does-not-exist/gc.log')), [])
        summary = bench.summarize_gc([], datetime.now(TZ), datetime.now(TZ), 200)
        self.assertEqual(summary['pauses'], 0)
        self.assertIsNone(summary['heap_after_mb'])


if __name__ == '__main__':
    unittest.main()
