from pathlib import Path
import shutil
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]


class RepositoryTestCase(unittest.TestCase):
    def temporary_path(self, prefix='sgp-test-') -> Path:
        path = Path(tempfile.mkdtemp(prefix=prefix))
        self.addCleanup(shutil.rmtree, path, True)
        return path
